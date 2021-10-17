import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/controllers/options/debug.dart';
import 'package:cumposter/controllers/postponed/create/time.dart';
import 'package:cumposter/enums/post_enums.dart';
import 'package:cumposter/models/images_model.dart';
import 'package:cumposter/utilities/date/unix_time.dart';
import 'package:http/http.dart' as http;
import 'package:cumposter/utilities/vk/get/get_wall_upload_server.dart';
import 'package:cumposter/utilities/vk/post/save_wall_photo.dart';
import 'package:cumposter/utilities/vk/post/wall_post.dart';
import '../posts.dart';
import 'images.dart';
import 'options.dart';
import 'package:mime/mime.dart';

class PostponedCreateController extends GetxController {
  static PostponedCreateController get to => Get.find();
  var canCreate = {}.obs;
  var postingStatus = PostingStatus.notInProgress.obs;
  var errorCode = 0.obs;

  fetchCanCreate() {
    var postponedPosts = PostponedPostsController.to.postponedPosts;
    var nextPostTime = PostponedCreateTimeController.to.nextPostTime.value;

    var statusMessages = [];
    if (postingStatus.value == PostingStatus.inProgress) {
      canCreate.value = {
        'canCreateStatus': false,
        'messages': ['Идет создание записи...'],
      };
    } else if (postingStatus.value == PostingStatus.finished) {
      canCreate.value = {
        'canCreateStatus': true,
        'messages': ['Запись успешно создана!'],
      };
    } else if (postingStatus.value == PostingStatus.error) {
      if (errorCode.value == 214) {
        canCreate.value = {
          'canCreateStatus': true,
          'messages': ['Ошибка: на это время есть отложенная запись'],
        };
      }
    } else {
      var now = DateTime.now();
      if (nextPostTime.isBefore(now)) {
        statusMessages.add('Некорректная дата');
        canCreate.value = {
          'canCreateStatus': false,
          'messages': statusMessages
        };
        return;
      }

      var postsWithNextPostTime = postponedPosts.where((post) =>
          getTimeFromUnixTime(post['date']) == nextPostTime);
      if (postsWithNextPostTime.isNotEmpty) {
        statusMessages.add('На эту дату уже запланирована запись');
        canCreate.value = {
          'canCreateStatus': false,
          'messages': statusMessages
        };
        return;
      }

      var text = PostponedCreateOptionsController.to.text.value;
      var checkedImages = PostponedCreateImagesController.to.imagesList;
      print(text);
      var imagesForPosting =
          checkedImages.where((image) => image.isChecked != false).toList();
      if (text.isEmpty && imagesForPosting.isEmpty) {
        statusMessages.add('Запись пуста');
      }
      var canCreateStatus = statusMessages.isEmpty;
      canCreate.value = {
        'canCreateStatus': canCreateStatus,
        'messages': statusMessages
      };
    }
  }

  void savePost() async {
    postingStatus.value = PostingStatus.inProgress;
    fetchCanCreate();
    var currentGroupId = CurrentGroupController.to.currentGroup.value.id;
    var imagesForUpload = await _getImagesForUpload();
    var uploadedImageList =
        await _getUploadedImages(currentGroupId, imagesForUpload);
    var res = await _wallPost(currentGroupId, uploadedImageList);
    if (res['success'] == false) {
      errorCode.value = res['errorCode'];
      postingStatus.value = PostingStatus.error;
      fetchCanCreate();
    } else {
      postingStatus.value = PostingStatus.finished;
      fetchCanCreate();
      try {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
        for (var image in imagesForUpload) {
          await image.imageFile.delete();
        }
      } catch (e) {
        DebugController.to.updateDebugErrors(e);
      }

      Timer(Duration(seconds: 1), () async {
        await PostponedPostsController.to.fetchPostponedPosts();
        PostponedCreateTimeController.to.fetchNextPostTime();
        PostponedCreateTimeController.to.fetchDateRangeString();
        await PostponedCreateImagesController.to.fetchImagesFromGallery();
        PostponedCreateOptionsController.to.clearText();
        postingStatus.value = PostingStatus.notInProgress;
        fetchCanCreate();
      });
    }

    // await Permission.storage.request();
    // await Permission.manageExternalStorage.request();
    // for (var image in imagesForUpload) {
    //   image.deleteSync();
    // }

    // await _postponedPostsController
    //     .fetchPostponedPosts(_currentGroupController.currentGroup['id']);
    // _postponedAddTimeController.fetchNextPostTime();
    // _postponedAddTimeController.fetchDateRangeString();
    // await _imagesFromGalleryController.fetchImagesFromGallery();
    // _postponedAddOptionsController.fetchImageCheckboxList();
    // _postponedAddOptionsController.updateText('');
    // fetchCanCreate();
  }
}

_wallPost(currentGroupId, uploadedImageList) async {
  var text = PostponedCreateOptionsController.to.text;
  var nextPostTime = PostponedCreateTimeController.to.nextPostTime;
  var nextPostTimeUnix = formatMapTypeToUnix(nextPostTime);
  var res = await wallPost(
      currentGroupId, text, uploadedImageList, 1, nextPostTimeUnix);
  return res;
}

_getUploadedImages(currentGroupId, imagesForUpload) async {
  var uploadedImageList = [];
  for (var imageForUpload in imagesForUpload) {
    var uploadUrl = await getWallUploadServer(currentGroupId);
    var uri = Uri.parse(uploadUrl);
    var multipartData = await _getMultipartFromFile(imageForUpload.imageFile);
    var request = http.MultipartRequest('POST', uri)
      ..files.add(
        multipartData,
      );
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var decodedBody = jsonDecode(response.body);
    var uploadedPhoto = await saveWallPhoto(currentGroupId,
        decodedBody['server'], decodedBody['photo'], decodedBody['hash']);
    var ownerId = uploadedPhoto['owner_id'];
    var photoId = uploadedPhoto['id'];
    //
    uploadedImageList.add('photo$ownerId' '_' '$photoId');
  }
  return uploadedImageList;
}

Future<List<ImageFromGallery>> _getImagesForUpload() async {
  List<ImageFromGallery> images = PostponedCreateImagesController.to.imagesList;

  List<ImageFromGallery> selectedImages =
      images.where((image) => image.isChecked == true).toList();

  return selectedImages;
}

_getMultipartFromFile(File fileImage) async {
  var mimeTypeData =
      lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])!.split('/');

  var file = await http.MultipartFile.fromPath('file', fileImage.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

  return file;
}

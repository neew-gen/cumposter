import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:vk_group_admin/controllers/options/debug.dart';
import 'package:vk_group_admin/controllers/postponed/add/time.dart';
import 'package:vk_group_admin/enums/post_enums.dart';
import 'package:vk_group_admin/utilities/date/unix_time.dart';
import 'package:http/http.dart' as http;
import 'package:vk_group_admin/utilities/vk/get/get_wall_upload_server.dart';
import 'package:vk_group_admin/utilities/vk/post/save_wall_photo.dart';
import 'package:vk_group_admin/utilities/vk/post/wall_post.dart';
import 'package:vk_group_admin/widgets/postponed/add_screen/error_dialog.dart';
import 'package:vk_group_admin/widgets/postponed/add_screen/posting_dialog.dart';
import '../posts.dart';
import 'options.dart';
import 'package:mime/mime.dart';

class PostponedCreateController extends GetxController {
  static PostponedCreateController get to => Get.find();
  var canCreate = {}.obs;
  var postingStatus = PostingStatus.notInProgress.obs;
  var errorCode = 0.obs;

  fetchCanCreate() {
    var postponedPosts = PostponedPostsController.to.postponedPosts;
    var nextPostTime = PostponedAddTimeController.to.nextPostTime;

    var statusMessages = [];
    print(postingStatus);
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
      var nextPostDateTime = DateTime(
          nextPostTime['year'],
          nextPostTime['month'],
          nextPostTime['day'],
          nextPostTime['hour'],
          nextPostTime['minute']);
      if (nextPostDateTime.isBefore(now)) {
        statusMessages.add('Некорректная дата');
      }

      var postsWithNextPostTime = postponedPosts.where((post) =>
          mapEquals(formatTimeFromUnixToMapType(post['date']), nextPostTime));
      if (postsWithNextPostTime.isNotEmpty) {
        statusMessages.add('На эту дату уже запланирована запись');
      }

      var text = PostponedAddOptionsController.to.text.value;
      var checkboxes = PostponedAddOptionsController.to.imageCheckboxList;
      var imagesForPosting = checkboxes.where((checkbox) => checkbox != false);
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
    // final CurrentGroupController _currentGroupController = Get.find();
    // final PostponedAddOptionsController _postponedAddOptionsController =
    //     Get.find();
    // final PostponedAddTimeController _postponedAddTimeController = Get.find();
    // final PostponedPostsController _postponedPostsController = Get.find();
    // final ImagesFromGalleryController _imagesFromGalleryController = Get.find();
    //
    postingStatus.value = PostingStatus.inProgress;
    fetchCanCreate();
    var currentGroupId = CurrentGroupController.to.currentGroup['id'];
    var imagesForUpload = await _getImagesForUpload();
    var uploadedImageList = await _getUploadedImages(currentGroupId);
    var res = await _wallPost(currentGroupId, uploadedImageList);
    if (res['success'] == false) {
      errorCode.value = res['errorCode'];
      postingStatus.value = PostingStatus.error;
      fetchCanCreate();
    } else {
      postingStatus.value = PostingStatus.finished;
      fetchCanCreate();
      Timer(Duration(seconds: 1), () async {
        try {

          await Permission.storage.request();
          await Permission.manageExternalStorage.request();
          for (var image in imagesForUpload) {
            await image.delete();
          }
        } catch (e) {
          DebugController.to.updateDebugErrors(e, 'PostponedCreateController');
        }

        await PostponedPostsController.to.fetchPostponedPosts(currentGroupId);
        PostponedAddTimeController.to.fetchNextPostTime();
        PostponedAddTimeController.to.fetchDateRangeString();
        await ImagesFromGalleryController.to.fetchImagesFromGallery();
        PostponedAddOptionsController.to.fetchImageCheckboxList();
        PostponedAddOptionsController.to.updateText('');
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
  var text = PostponedAddOptionsController.to.text;
  var nextPostTime = PostponedAddTimeController.to.nextPostTime;
  var nextPostTimeUnix = formatMapTypeToUnix(nextPostTime);
  var res = await wallPost(
      currentGroupId, text, uploadedImageList, 1, nextPostTimeUnix);
  return res;
}

_getUploadedImages(currentGroupId) async {
  var imagesForUpload = await _getImagesForUpload();
  var uploadedImageList = [];
  for (var imageForUpload in imagesForUpload) {
    var uploadUrl = await getWallUploadServer(currentGroupId);
    var uri = Uri.parse(uploadUrl);
    var multipartData = await _getMultipartFromFile(imageForUpload);
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

_getImagesForUpload() async {
  var images = ImagesFromGalleryController.to.imageList;
  print(images);
  var selectedImages = PostponedAddOptionsController.to.imageCheckboxList;
  print(selectedImages);
  var imagesForUpload = [];
  selectedImages.asMap().forEach((index, value) => {
        if (value) {imagesForUpload.add(images[index])}
      });
  return imagesForUpload;
}

_getMultipartFromFile(File fileImage) async {
  var mimeTypeData =
      lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])!.split('/');

  var file = await http.MultipartFile.fromPath('file', fileImage.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

  return file;
}

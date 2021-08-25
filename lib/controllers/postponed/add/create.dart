import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/images_from_gallery.dart';
import 'package:vk_group_admin/controllers/postponed/add/time.dart';
import 'package:vk_group_admin/utilities/date/unix_time.dart';
import 'package:http/http.dart' as http;
import 'package:vk_group_admin/utilities/vk/get/get_wall_upload_server.dart';
import 'package:vk_group_admin/utilities/vk/post/save_wall_photo.dart';
import 'package:vk_group_admin/utilities/vk/post/wall_post.dart';
import '../posts.dart';
import 'options.dart';
import 'package:mime/mime.dart';

class PostponedCreateController extends GetxController {
  var canCreate = {}.obs;

  fetchCanCreate() {
    final PostponedPostsController _postponedPostsController = Get.find();
    final PostponedAddTimeController _postponedAddTimeController = Get.find();
    final PostponedAddOptionsController _postponedAddOptionsController =
        Get.find();

    var postponedPosts = _postponedPostsController.postponedPosts;
    var nextPostTime = _postponedAddTimeController.nextPostTime;

    var statusMessages = [];

    var now = DateTime.now();
    var nextPostDateTime = DateTime(nextPostTime['year'], nextPostTime['month'],
        nextPostTime['day'], nextPostTime['hour'], nextPostTime['minute']);
    if (nextPostDateTime.isBefore(now)) {
      statusMessages.add('Некорректная дата');
    }

    var postsWithNextPostTime = postponedPosts.where((post) =>
        mapEquals(formatTimeFromUnixToMapType(post['date']), nextPostTime));
    if (postsWithNextPostTime.isNotEmpty) {
      statusMessages.add('На эту дату уже запланирована запись');
    }

    var text = _postponedAddOptionsController.text.value;
    var checkboxes = _postponedAddOptionsController.imageCheckboxList;
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

  void savePost() async {
    final CurrentGroupController _currentGroupController = Get.find();
    final PostponedAddOptionsController _postponedAddOptionsController =
        Get.find();
    final PostponedAddTimeController _postponedAddTimeController = Get.find();
    final PostponedPostsController _postponedPostsController = Get.find();
    final ImagesFromGalleryController _imagesFromGalleryController = Get.find();
    //
    var imagesForUpload = await _getImagesForUpload();
    var uploadedImageList = [];
    for (var imageForUpload in imagesForUpload) {
      var uploadUrl =
          await getWallUploadServer(_currentGroupController.currentGroup['id']);
      var uri = Uri.parse(uploadUrl);
      var multipartData = await _getMultipartFromFile(imageForUpload);
      var request = http.MultipartRequest('POST', uri)
        ..files.add(
          multipartData,
        );
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var decodedBody = jsonDecode(response.body);
      var uploadedPhoto = await saveWallPhoto(
          _currentGroupController.currentGroup['id'],
          decodedBody['server'],
          decodedBody['photo'],
          decodedBody['hash']);
      var ownerId = uploadedPhoto['owner_id'];
      var photoId = uploadedPhoto['id'];
      //
      uploadedImageList.add('photo$ownerId' '_' '$photoId');
    }

    var nextPostTimeUnix =
        formatMapTypeToUnix(_postponedAddTimeController.nextPostTime);
    await wallPost(
        _currentGroupController.currentGroup['id'],
        _postponedAddOptionsController.text,
        uploadedImageList,
        1,
        nextPostTimeUnix);
    // await _requestPerms();
    // if (await Permission.storage.isGranted) {
    //   for (var image in imagesForUpload) {
    //     image.deleteSync();
    //   }
    // }
    await Permission.manageExternalStorage.request();
    for (var image in imagesForUpload) {
      image.deleteSync();
    }

    await _postponedPostsController
        .fetchPostponedPosts(_currentGroupController.currentGroup['id']);
    _postponedAddTimeController.fetchNextPostTime();
    _postponedAddTimeController.fetchDateRangeString();
    await _imagesFromGalleryController.fetchImagesFromGallery();
    _postponedAddOptionsController.fetchImageCheckboxList();
    _postponedAddOptionsController.updateText('');
    fetchCanCreate();
  }
}

_getImagesForUpload() async {
  final ImagesFromGalleryController _imagesFromGalleryController = Get.find();
  final PostponedAddOptionsController _postponedAddOptionsController =
      Get.find();
  var images = _imagesFromGalleryController.imageList;
  var selectedImages = _postponedAddOptionsController.imageCheckboxList;
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
// _requestPerms() async {
//   Map<Permission, PermissionStatus> statuses = await
//   [
//     Permission.storage,
//     Permission.manageExternalStorage
//   ].request();
//   return statuses;
// }

// class CounterStorage {
//   Future<String> get _localPath async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//
//     return appDocPath;
//   }
//
//   Future<File> get _localFile async {
//     final path = await _localPath;
//     print('path ${path}');
//     return File('$path/counter.txt');
//   }
//
//   Future<int> deleteFile() async {
//     try {
//       final file = await _localFile;
//
//       await file.delete();
//     } catch (e) {
//       return 0;
//     }
//   }
//
//   Future<int> readCounter() async {
//     try {
//       final file = await _localFile;
//
//       // Read the file
//       String contents = await file.readAsString();
//
//       return int.parse(contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return 0;
//     }
//   }
//
//   Future<File> writeCounter(int counter) async {
//     final file = await _localFile;
//
//     // Write the file
//     return file.writeAsString('$counter');
//   }
// }

import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vk_group_admin/utilities/files/images/is_image.dart';

class ImagesFromGalleryController extends GetxController {
  var imageList = [].obs;
  var entityList = [].obs;

  Future fetchImagesFromGallery() async {
    await Permission.manageExternalStorage.request();
    var downloadsFolderPath = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    var filesList = Directory(downloadsFolderPath!).listSync();
    var images = [];
    for (var file in filesList) {
      var path = file.path;
      if (isImage(path)) {
        images.add(file);
      }
    }
    // сортировка по убыванию
    images.sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));
    imageList.value = images;
    // if (await Permission.storage.request().isGranted) {
    //   var downloadsFolderPath = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    //   var filesList = Directory(downloadsFolderPath!).listSync();
    //   var images = [];
    //   for (var file in filesList) {
    //     var path = file.path;
    //     if (isImage(path)) {
    //       images.add(file);
    //     }
    //   }
    //   // сортировка по убыванию
    //   images.sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));
    //   imageList.value = images;
    // }
  }
}

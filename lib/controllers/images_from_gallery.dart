import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vk_group_admin/utilities/files/images/is_image.dart';

import 'options/debug.dart';


class ImagesFromGalleryController extends GetxController {
  var imageList = [].obs;
  var entityList = [].obs;

  static ImagesFromGalleryController get to => Get.find();

  Future fetchImagesFromGallery() async {
    try {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();

      var downloadsFolderPath =
      await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);

      DebugController.to.updateDebugConsole(downloadsFolderPath, 'ImagesFromGalleryController');

      var filesList = Directory(downloadsFolderPath!).listSync();
      DebugController.to.updateDebugConsole(filesList.length, 'ImagesFromGalleryController');

      // var images = [];
      // DebugController.to.updateDebugConsole(images, 'ImagesFromGalleryController');

      // сортировка по убыванию
      // images.sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));
      imageList.value = filesList;
    } catch (e) {
      DebugController.to.updateDebugErrors(e, 'ImagesFromGalleryController');
    }
  }
}

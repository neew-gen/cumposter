import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vk_group_admin/models/postponed/postponed_create_models.dart';
import 'package:uuid/uuid.dart';

import '../../options/debug.dart';

class PostponedCreateImagesController extends GetxController {
  static PostponedCreateImagesController get to => Get.find();
  RxList<PostponedCreateImage> imagesList = <PostponedCreateImage>[].obs;

  Future fetchImagesFromGallery() async {
    try {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();

      String? downloadsFolderPath =
          await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_DOWNLOADS);
      DebugController.to.updateDebugConsole(
          downloadsFolderPath, 'ImagesFromGalleryController');

      List<FileSystemEntity> allDownloadsFiles =
          Directory(downloadsFolderPath!).listSync();
      List<File> imagesFiles = [];
      for (var file in allDownloadsFiles) {
        if (isImage(file.path)) {
          imagesFiles.add(file as File);
        }
      }
      // сортировка по убыванию
      imagesFiles
          .sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));

      List<PostponedCreateImage> postponedCreateImages = [];
      for (int i = 0; i < imagesFiles.length; i++) {
        var uuid = Uuid();
        PostponedCreateImage postponedCreateImage = PostponedCreateImage(uuid.v4(), imagesFiles[i], false);
        postponedCreateImages.add(postponedCreateImage);
      }
      DebugController.to
          .updateDebugConsole(postponedCreateImages.length, 'ImagesFromGalleryController');
      imagesList.value = postponedCreateImages;
    } catch (e) {
      DebugController.to.updateDebugErrors(e, 'ImagesFromGalleryController');
    }
  }

  void updateImageCheckbox(id, value) {
    var imageForUpdate = imagesList.where((image) => image.id == id).toList()[0];
    imageForUpdate.isChecked= value;
  }
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path);

  return mimeType!.startsWith('image/');
}

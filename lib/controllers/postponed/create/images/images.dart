import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cumposter/models/images_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

import 'images_path.dart';

class PostponedCreateImagesController extends GetxController {
  static PostponedCreateImagesController get to => Get.find();
  RxList<ImageFromGallery> imagesList = <ImageFromGallery>[].obs;

  Future fetchImagesFromGallery() async {
    try {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();

      var folderPath =
          PostponedCreateImagesPathController.to.imagesPath.value;

      List<FileSystemEntity> allDownloadsFiles =
          Directory(folderPath).listSync();
      List<File> imagesFiles = [];
      for (var file in allDownloadsFiles) {
        if (isImage(file.path)) {
          imagesFiles.add(file as File);
        }
      }
      // сортировка по убыванию
      imagesFiles.sort(
          (a, b) => b.statSync().changed.compareTo(a.statSync().changed));

      List<ImageFromGallery> postponedCreateImages = [];
      for (int i = 0; i < imagesFiles.length; i++) {
        Uuid uuid = Uuid();
        ImageFromGallery postponedCreateImage =
            ImageFromGallery(uuid.v4(), imagesFiles[i], false);
        postponedCreateImages.add(postponedCreateImage);
      }
      imagesList.value = postponedCreateImages;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void updateImageCheckbox(id, value) {
    var imageForUpdate =
        imagesList.where((image) => image.id == id).toList()[0];
    imageForUpdate.isChecked = value;
  }
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path);
  if (mimeType == null) {
    return false;
  } else {
    return mimeType.startsWith('image/');
  }
}

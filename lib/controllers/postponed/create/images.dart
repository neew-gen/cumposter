import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cumposter/models/images_model.dart';
import 'package:uuid/uuid.dart';

class PostponedCreateImagesController extends GetxController {
  static PostponedCreateImagesController get to => Get.find();
  RxList<ImageFromGallery> imagesList = <ImageFromGallery>[].obs;

  Future fetchImagesFromGallery() async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();

    String? downloadsFolderPath =
        await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);

    if (downloadsFolderPath != null) {
      List<FileSystemEntity> allDownloadsFiles =
          Directory(downloadsFolderPath).listSync();
      List<File> imagesFiles = [];
      for (var file in allDownloadsFiles) {
        if (isImage(file.path)) {
          imagesFiles.add(file as File);
        }
      }
      // сортировка по убыванию
      imagesFiles
          .sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));

      List<ImageFromGallery> postponedCreateImages = [];
      for (int i = 0; i < imagesFiles.length; i++) {
        Uuid uuid = Uuid();
        ImageFromGallery postponedCreateImage =
        ImageFromGallery(uuid.v4(), imagesFiles[i], false);
        postponedCreateImages.add(postponedCreateImage);
      }
      imagesList.value = postponedCreateImages;
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

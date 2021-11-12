import 'dart:io';

import 'package:cumposter/providers/firebase/postponed/create/images_settings.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cumposter/models/images_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

class PostponedCreateImagesPathController extends GetxController {
  static PostponedCreateImagesPathController get to => Get.find();
  var imagesPath = ''.obs;
  updateImagesPath(newPath) {
    imagesPath.value = newPath;
    ImagesSettings().update({'path': newPath});
  }

  static initialBinding() {
    Get.put<PostponedCreateImagesPathController>(
        PostponedCreateImagesPathController(),
        permanent: true);
  }
}

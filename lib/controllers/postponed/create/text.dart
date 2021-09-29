import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostponedCreateTextController extends GetxController {
  static PostponedCreateTextController get to => Get.find();

  final GlobalKey<FormState> optionsFormKey = GlobalKey<FormState>();
  late TextEditingController textController;

  Rx<String> text = ''.obs;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
  }

  @override
  void onClose() {
    textController.dispose();
  }

  void clearText() {
    textController.text = '';
    text.value = '';
  }

  static initialBinding() {
    Get.put<PostponedCreateTextController>(PostponedCreateTextController(),
        permanent: true);
  }
}

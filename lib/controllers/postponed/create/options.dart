import 'package:get/get.dart';

class PostponedCreateOptionsController extends GetxController {
  static PostponedCreateOptionsController get to => Get.find();

  var text = ''.obs;
  void updateText(newValue) async {
    text.value = newValue;
  }

  var deleteImageAfterSave = false.obs;
  void updateDeleteImageAfterSave(newValue) async {
    deleteImageAfterSave = newValue;
  }

  var signed = true.obs;
  void updateSigned(newValue) async {
    signed = newValue;
  }
}

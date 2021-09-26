import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/utilities/firebase/get/get_group_settings.dart';
import 'package:cumposter/utilities/firebase/update/update_group_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostponedCreateOptionsController extends GetxController {
  static PostponedCreateOptionsController get to => Get.find();

  Rx<bool> isShowOptions = false.obs;
  void fetchShowOptions() async {
  var groupId = CurrentGroupController.to.currentGroup.value.id;
  var res = await getShowOptions(groupId);
  isShowOptions.value = res;
}
  Future<void> updateShowOptions(newValue) async {
    isShowOptions.value = newValue;
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    await updateShowOptionsInFirebase(groupId, newValue);
  }

  final GlobalKey<FormState> optionsFormKey = GlobalKey<FormState>();
  late TextEditingController textController;
  var text = ''.obs;
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

  var deleteImageAfterSave = false.obs;
  void updateDeleteImageAfterSave(newValue) async {
    deleteImageAfterSave = newValue;
  }

  var signed = true.obs;
  void updateSigned(newValue) async {
    signed = newValue;
  }
}

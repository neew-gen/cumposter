import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/utilities/firebase/get/get_group_settings.dart';
import 'package:cumposter/utilities/firebase/update/update_group_settings.dart';
import 'package:get/get.dart';

class PostponedCreateOptionsController extends GetxController {
  static PostponedCreateOptionsController get to => Get.find();

  Rx<bool> isShowOptions = false.obs;
  Rx<bool> isInitUpdateBecauseChangeShowOptions = false.obs;
  void fetchShowOptions() async {
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    var res = await getShowOptions(groupId);
    isShowOptions.value = res;
  }

  Future<void> updateShowOptions(newValue) async {
    isInitUpdateBecauseChangeShowOptions.value = true;
    isShowOptions.value = newValue;
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    await updateShowOptionsInFirebase(groupId, newValue);
    isInitUpdateBecauseChangeShowOptions.value = false;
  }

  Rx<bool> deleteImageAfterSave = false.obs;
  // void fetchShowOptions() async {
  //   var groupId = CurrentGroupController.to.currentGroup.value.id;
  //   var res = await getShowOptions(groupId);
  //   isShowOptions.value = res;
  // }
  void updateDeleteImageAfterSave(newValue) async {
    deleteImageAfterSave = newValue;
  }

  var signed = true.obs;
  void updateSigned(newValue) async {
    signed = newValue;
  }

  static initialBinding() {
    Get.put<PostponedCreateOptionsController>(
        PostponedCreateOptionsController(),
        permanent: true);
  }
}

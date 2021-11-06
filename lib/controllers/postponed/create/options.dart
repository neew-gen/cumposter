import 'package:cumposter/controllers/groups/settings.dart';
import 'package:get/get.dart';

class PostponedCreateOptionsController extends GetxController {
  static PostponedCreateOptionsController get to => Get.find();

  Rx<bool> isShowOptions = false.obs;
  Rx<bool> isInitUpdateBecauseChangeShowOptions = false.obs;
  // void fetchShowOptions() async {
  // print(isShowOptions);
  // var groupId = CurrentGroupController.to.currentGroup.value.id;
  // var res = await getShowOptions(groupId);
  // isShowOptions.value = res;
  // }

  Future<void> updateShowOptions(newValue) async {
    isInitUpdateBecauseChangeShowOptions.value = true;
    await GroupSettingsController.to
        .updateGroupViewSettings('isShowOptions', newValue);
    isInitUpdateBecauseChangeShowOptions.value = false;
  }

  Rx<bool> deleteAfterPosting = false.obs;
  // void fetchShowOptions() async {
  //   var groupId = CurrentGroupController.to.currentGroup.value.id;
  //   var res = await getShowOptions(groupId);
  //   isShowOptions.value = res;
  // }
  void updateDeleteAfterPosting(newValue) async {
    deleteAfterPosting.value = newValue;
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

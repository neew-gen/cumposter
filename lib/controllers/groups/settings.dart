import 'package:cumposter/utilities/firebase/get/get_group_settings.dart';
import 'package:cumposter/utilities/firebase/update/update_group_settings.dart';
import 'package:get/get.dart';

import 'current.dart';

class GroupSettingsController extends GetxController {
  static GroupSettingsController get to => Get.find();
  var postTimeSettings = {}.obs;
  var defaultPostTimeSettings = {};

  void fetchGroupTimeSettings() async {
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    var res = await getPostTimeSettings(groupId);
    defaultPostTimeSettings = res;
    postTimeSettings.value = res;
  }
  updateGroupTimeSettings(field, value) async {
    postTimeSettings[field] = value;
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    await updatePostTimeSettings(groupId, field, value);
  }
}

import 'package:cumposter/controllers/postponed/create/options.dart';
import 'package:cumposter/providers/firebase/firebase_provider.dart';
import 'package:cumposter/providers/firebase/postponed/create/time_settings.dart';
import 'package:cumposter/providers/firebase/postponed/create/view_settings.dart';
import 'package:cumposter/utilities/next_post_time/convert_post_time.dart';
import 'package:get/get.dart';
import 'package:cumposter/utilities/credentials.dart';

import 'current.dart';

class GroupSettingsController extends GetxController {
  static GroupSettingsController get to => Get.find();
  var postTimeSettings = {}.obs;
  // var defaultPostTimeSettings = {};
  var timeSettings = TimeSettings();
  var viewSettings = ViewSettings();

  var postViewSettings = {}.obs;

  void fetchAllGroupSettings() async {
    // fetch time settings
    var userId = await UserId.get();
    var groupId = CurrentGroupController.to.currentGroup.value.id;
    var allGroupSettings = await FirebaseProvider.getColData(
        'users/$userId/groups/$groupId/settings');
    var time = await timeSettings.fetch(allGroupSettings['time']);
    postTimeSettings.value = time;
    var view = await viewSettings.fetch(allGroupSettings['view']);
    postViewSettings.value = view;
    PostponedCreateOptionsController.to.isShowOptions.value =
        view['isShowOptions'];
  }

  void fetchGroupTimeSettings() async {
    var res = await timeSettings.fetch();
    // defaultPostTimeSettings = res;
    postTimeSettings.value = res;
  }

  updateGroupTimeSettings(field, value) async {
    postTimeSettings[field] = value;
    var dataForUpdate = convertPostTimeToMap(postTimeSettings);
    await timeSettings.update(dataForUpdate);
  }

  updateGroupViewSettings(field, value) async {
    postViewSettings[field] = value;
    PostponedCreateOptionsController.to.isShowOptions.value = value;
    await viewSettings.update(postViewSettings);
  }
}

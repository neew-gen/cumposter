import 'package:cumposter/constants/group_params.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/providers/firebase/firebase_provider.dart';
import 'package:cumposter/utilities/credentials.dart';
import 'package:cumposter/utilities/firebase/methods/need_to_update_settings.dart';
import 'package:cumposter/utilities/next_post_time/convert_post_time.dart';

class TimeSettings {
  Future<String?> get _userId async => await UserId.get();
  String get _groupId => CurrentGroupController.to.currentGroup.value.id;

  fetch([timeSettingsFromExternalSource]) async {
    var timeSettings = timeSettingsFromExternalSource;
    if (timeSettingsFromExternalSource == null) {
      timeSettings = await _getTimeSettings();
    }
    if (timeSettings == null) {
      _setTimeSettings(defaultTimeSettings);
      return convertMapToPostTime(defaultTimeSettings);
    }
    if (checkIsNeedToUpdateSettings(timeSettings, defaultTimeSettings)) {
      var dataForUpdate =
          getDataForUpdateSettings(timeSettings, defaultTimeSettings);
      update(dataForUpdate);
      return convertMapToPostTime(dataForUpdate);
    }
    return convertMapToPostTime(timeSettings);
  }

  _getTimeSettings() async {
    final userId = await _userId;
    return await FirebaseProvider.getDocData(
        'users/$userId/groups/$_groupId/settings', 'time');
  }
  _setTimeSettings(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.setDocData(
        'users/$userId/groups/$_groupId/settings', 'time', settingForUpdate);
  }

  update(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.updateDocData(
        'users/$userId/groups/$_groupId/settings', 'time', settingForUpdate);
  }
}

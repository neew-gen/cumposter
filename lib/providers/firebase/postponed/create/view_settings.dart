import 'package:cumposter/constants/group_params.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/providers/firebase/firebase_provider.dart';
import 'package:cumposter/utilities/credentials.dart';
import 'package:cumposter/utilities/firebase/methods/need_to_update_settings.dart';
import 'package:cumposter/utilities/next_post_time/convert_post_time.dart';

class ViewSettings {
  Future<String?> get _userId async => await UserId.get();
  String get _groupId => CurrentGroupController.to.currentGroup.value.id;

  fetch([viewSettingsFromExternalSource]) async {
    var viewSettings = viewSettingsFromExternalSource;
    if (viewSettingsFromExternalSource == null) {
      viewSettings = await _getViewSettings();
    }
    if (viewSettings == null) {
      _setViewSettings(defaultViewSettings);
      return defaultViewSettings;
    }
    if (checkIsNeedToUpdateSettings(viewSettings, defaultViewSettings)) {
      var dataForUpdate =
      getDataForUpdateSettings(viewSettings, defaultViewSettings);
      update(dataForUpdate);
      return dataForUpdate;
    }
    return viewSettings;
  }

  _getViewSettings() async {
    final userId = await _userId;
    return await FirebaseProvider.getDocData(
        'users/$userId/groups/$_groupId/settings', 'view');
  }
  _setViewSettings(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.setDocData(
        'users/$userId/groups/$_groupId/settings', 'view', settingForUpdate);
  }

  update(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.updateDocData(
        'users/$userId/groups/$_groupId/settings', 'view', settingForUpdate);
  }
}

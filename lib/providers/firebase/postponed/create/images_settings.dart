import 'dart:io';

import 'package:cumposter/constants/group_params.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/providers/firebase/firebase_provider.dart';
import 'package:cumposter/utilities/credentials.dart';
import 'package:cumposter/utilities/firebase/methods/need_to_update_settings.dart';
import 'package:ext_storage/ext_storage.dart';

class ImagesSettings {
  Future<String?> get _userId async => await UserId.get();
  String get _groupId => CurrentGroupController.to.currentGroup.value.id;

  fetch([imagesSettingsFromExternalSource]) async {
    var imagesSettings = imagesSettingsFromExternalSource;
    if (imagesSettingsFromExternalSource == null) {
      imagesSettings = await _getImagesSettings();
    }
    var extractedDefaultImagesSettings =
        await _extractImagesSettings(defaultImagesSettings);
    if (imagesSettings == null) {
      _setImagesSettings(extractedDefaultImagesSettings);
      return extractedDefaultImagesSettings;
    }
    if (checkIsNeedToUpdateSettings(
        imagesSettings, extractedDefaultImagesSettings)) {
      var dataForUpdate = getDataForUpdateSettings(
          imagesSettings, extractedDefaultImagesSettings);
      update(dataForUpdate);
      return await _extractImagesSettings(dataForUpdate);
    }
    return await _extractImagesSettings(imagesSettings);
  }

  update(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.updateDocData(
        'users/$userId/groups/$_groupId/settings', 'images', settingForUpdate);
  }

  _getImagesSettings() async {
    final userId = await _userId;
    return await FirebaseProvider.getDocData(
        'users/$userId/groups/$_groupId/settings', 'images');
  }

  _setImagesSettings(settingForUpdate) async {
    final userId = await _userId;
    await FirebaseProvider.setDocData(
        'users/$userId/groups/$_groupId/settings', 'images', settingForUpdate);
  }

  _extractImagesSettings(imageSettings) async {
    var extractedImagesSettings = Map.from(imageSettings);
    if (imageSettings['path'] == 'default') {
      extractedImagesSettings['path'] =
          await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_DOWNLOADS);
    }
    var isPathExist = await _checkIsPathExist(extractedImagesSettings['path']);
    if (!isPathExist) {
      extractedImagesSettings['path'] = defaultImagesSettings['path'];
      await update(extractedImagesSettings);
      if (imageSettings['path'] == 'default') {
        extractedImagesSettings['path'] =
        await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
      }
    }
    return extractedImagesSettings;
  }
  _checkIsPathExist(path) async {
    return await Directory(path).exists();
  }
}

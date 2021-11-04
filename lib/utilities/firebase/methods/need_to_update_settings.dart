checkIsNeedToUpdateSettings(currentSettings, defaultSettings) {
  bool isNeedToUpdate = false;
  defaultSettings.forEach((key, value) => {
        if (!currentSettings.containsKey(key)) {isNeedToUpdate = true}
      });
  return isNeedToUpdate;
}

getDataForUpdateSettings(currentSettings, defaultSettings) {
  var dataForUpdate = currentSettings;
  defaultSettings.forEach((key, value) => {
        if (!currentSettings.containsKey(key)) {dataForUpdate[key] = value}
      });
  return dataForUpdate;
}

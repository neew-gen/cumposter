import 'dart:convert';

import 'package:cumposter/constants/group_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/get/get_group_settings.dart';
import 'firebase/update/update_group_settings.dart';

class GroupParams {
  // final String paramName;
  // final dynamic paramValue;
  // GroupParam(this.paramName, this.paramValue);

  Future<dynamic> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const List<String> paramsIds = [
      'startTime',
      'endTime',
      'stepTime',
      'isShowOptions'
    ];
    var allGroupParams = [];
    var resultParams = [];
    for (final id in paramsIds) {
      final String? valueFromPrefs = prefs.getString(id);
      if (valueFromPrefs == null) {
        if (allGroupParams.isEmpty) {
          allGroupParams = await getAllGroupSettings();
        }
        // var findParam = allGroupParams.where((param) => ids.contains(u["id"]));
        var findParam = allGroupParams.firstWhere(
          (param) => param['id'] == id,
          orElse: () => null,
        );
        if (findParam == null) {
          final value = defaultGroupParams[id];
          updateGroupParam(id, value);
          prefs.setString(id, jsonEncode(value));
          resultParams.add({'id': id, 'value': value});
        } else {
          final value = findParam['value'];
          prefs.setString(id, jsonEncode(value));
          resultParams.add({'id': id, 'value': value});
        }
      } else {
        final value = jsonDecode(valueFromPrefs);
        if (allGroupParams.isEmpty) {
          allGroupParams = await getAllGroupSettings();
        }
        var findParam = allGroupParams.firstWhere(
          (param) => param.id == id,
          orElse: () => null,
        );
        if (findParam == null) {
          final value = defaultGroupParams[id];
          updateGroupParam(id, value);
        }
        resultParams.add({'id': id, 'value': value});
      }
    }
    print(resultParams);
    return prefs.getString('startTime');
  }

  void getDefault(paramName) {}

  Future<void> set(String? token) async {
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', token);
    }
  }
}

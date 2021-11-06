import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/utilities/credentials.dart';
import 'package:http/http.dart' as http;

import '../firebase_provider.dart';

class UnsubscribersProvider {
  // Future<String?> get _userId async => await UserId.get();
  String get _groupId => CurrentGroupController.to.currentGroup.value.id;

  fetch() async {
    var unsubscribersIsExist = await _checkUnsubscribersIsExist();
    if (!unsubscribersIsExist) {
      var token = await AccessToken.get();
      var url = 'http://10.0.2.2:3000/vk/confirm-who-unsubscribe-server';
      // Map<String, String> queryParams = {
      //   'access_token': token!,
      // };
      // String queryString = Uri(queryParameters: queryParams).query;
      // var requestUrl = url + '?' + queryString;
      return http
          .post(Uri.parse(url), body: {'token': token, 'groupId': _groupId});
    }
  }

  _checkUnsubscribersIsExist() async {
    return await FirebaseProvider.checkDocIsExist(
        'groups/$_groupId/unsubscribers', 'list');
  }
}

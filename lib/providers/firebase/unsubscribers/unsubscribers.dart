import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/utilities/credentials.dart';
import 'package:cumposter/utilities/vk/get/get_users.dart';
import 'package:http/http.dart' as http;

import '../firebase_provider.dart';

class UnsubscribersProvider {
  // Future<String?> get _userId async => await UserId.get();
  String get _groupId => CurrentGroupController.to.currentGroup.value.id;

  fetch() async {
    var unsubscribersIsExist = await _checkUnsubscribersIsExist();
    if (!unsubscribersIsExist) {
      var token = await AccessToken.get();
      var url =
          'https://cumposter-backend.herokuapp.com/vk/confirm-who-unsubscribe-server';
      // var url = 'http://10.0.2.2:3000/vk/confirm-who-unsubscribe-server';
      await http
          .post(Uri.parse(url), body: {'token': token, 'groupId': _groupId});
      return [];
    } else {
      var data = await _getUnsubscribersData();
      var unsubscribersList = data['unsubscribersList'];
      var usersById = await _getUsersByIds(unsubscribersList);
      return usersById;
    }
  }

  _checkUnsubscribersIsExist() async {
    return await FirebaseProvider.checkDocIsExist(
        'groups/$_groupId/unsubscribers', 'list');
  }

  _getUnsubscribersData() async {
    return await FirebaseProvider.getDocData(
        'groups/$_groupId/unsubscribers', 'list');
  }

  _getUsersByIds(unsubscribersList) async {
    Set unsubscribersSet = {};
    unsubscribersList.forEach((item) => {unsubscribersSet.add(item['userId'])});
    var unsubscribersIds = unsubscribersSet.toList();
    var users = await getUsers(unsubscribersIds, ['domain']);
    var modifiedUnsubscribersList = [];
    for (var unsubscribersItem in unsubscribersList) {
      var foundUser = users.firstWhere(
          (usersItem) => usersItem['id'] == unsubscribersItem['userId']);
      var modifiedItem = unsubscribersItem;
      modifiedItem['domain'] = foundUser['domain'];
      modifiedItem['name'] =
          '${foundUser['first_name']} ${foundUser['last_name']}';
      modifiedUnsubscribersList.add(modifiedItem);
    }
    return modifiedUnsubscribersList;
  }
}

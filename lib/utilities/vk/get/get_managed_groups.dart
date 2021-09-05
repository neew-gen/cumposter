import 'dart:convert';

import 'package:cumposter/models/managed_groups_model.dart';

import '../../credentials.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<ManagedGroup>> getManagedGroups() async {
  String? token = await AccessToken.get();
  String? userId = await UserId.get();

  Response res = await http.get(Uri.parse(
      'https://api.vk.com/method/groups.get?user_id=$userId&filter=admin,editor,moder&extended=1&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);

  List<ManagedGroup> managedGroups = [];
  for (var item in decodedBody['response']['items']) {
    ManagedGroup managedGroup =
        ManagedGroup(item['id'].toString(), item['name'], item['photo_50']);
    managedGroups.add(managedGroup);
  }
  return managedGroups;
}

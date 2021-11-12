import 'dart:convert';

import 'package:cumposter/models/managed_groups_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../credentials.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<ManagedGroup>?> getManagedGroups() async {
  try {
    String? token = await AccessToken.get();
    String? userId = await UserId.get();

    Response res = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.get?user_id=$userId'
            '&filter=admin,editor,moder'
            '&extended=1'
            '&fields=members_count'
            '&access_token=$token'
            '&v=5.131'));
    var decodedBody = jsonDecode(res.body);
    List<ManagedGroup> managedGroups = [];
    for (var item in decodedBody['response']['items']) {
      ManagedGroup managedGroup =
      ManagedGroup(item['id'].toString(), item['name'], item['photo_200'], item['members_count']);
      managedGroups.add(managedGroup);
    }
    return managedGroups;
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}

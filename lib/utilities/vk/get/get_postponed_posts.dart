import 'dart:convert';
import 'package:http/http.dart';
import '../../credentials.dart';
import 'package:http/http.dart' as http;

getPostponedPosts(String groupId) async {
  String? token = await AccessToken.get();
  Response res = await http.get(Uri.parse(
      'https://api.vk.com/method/wall.get?owner_id=-$groupId&filter=postponed&count=100&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  // print(decodedBody['response']['items'][0]);
  return decodedBody['response']['items'];
}

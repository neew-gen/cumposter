import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vk_group_admin/utilities/vk/vk_http.dart';

import '../../credentials.dart';
import 'package:http/http.dart' as http;

getPostponedPosts(String groupId) async {
  var token = await AccessToken.get();
  var res = await http.get(Uri.parse(
      'https://api.vk.com/method/wall.get?owner_id=-$groupId&filter=postponed&count=100&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  return decodedBody['response']['items'];

  // var vkHttp = VkHttp();
  // var res = await vkHttp.get("/postponed-posts", {"group_id": groupId});
  // var decodedBody = jsonDecode(res.body);
  // return decodedBody["items"];
}

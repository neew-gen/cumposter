import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vk_group_admin/utilities/vk/vk_http.dart';

import '../../credentials.dart';
import 'package:http/http.dart' as http;

getManagedGroups() async {
  var token = await AccessToken.get();
  var userId = await UserId.get();
  var res = await http.get(Uri.parse(
      'https://api.vk.com/method/groups.get?user_id=$userId&filter=admin,editor,moder&extended=1&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  return decodedBody['response']['items'];

  // var vkHttp = VkHttp();
  // final prefs = await SharedPreferences.getInstance();
  // var id = prefs.getString("user_id");
  // var res = await vkHttp.get("/managed-groups", {"id": id!});
  // var decodedBody = jsonDecode(res.body);
  // return decodedBody["items"];
}

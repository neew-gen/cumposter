import 'dart:convert';

import '../../credentials.dart';
import 'package:http/http.dart' as http;

getUsers(ids) async {
  var token = await AccessToken.get();
  var idsString = ids.join(',');
  var res = await http.get(Uri.parse(
      'https://api.vk.com/method/users.get?user_ids=$idsString&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  return decodedBody['response'];

//   var vkHttp = VkHttp();
//   var res = await vkHttp.delete("/postponed-posts", {"group_id": groupId, "post_id": postId});
//   print(res);
//   return res;
// //   var decodedBody = jsonDecode(res.body);
// //   print(decodedBody);
// //   return decodedBody["items"];
}

import '../../credentials.dart';
import '../vk_http.dart';
import 'package:http/http.dart' as http;

deletePostponedPost(String groupId, String postId) async {
  var token = await AccessToken.get();
  var res = await http.post(Uri.parse('https://api.vk.com/method/wall.delete?owner_id=-$groupId&post_id=$postId&access_token=$token&v=5.131'));
  return res;
//   var vkHttp = VkHttp();
//   var res = await vkHttp.delete("/postponed-posts", {"group_id": groupId, "post_id": postId});
//   print(res);
//   return res;
// //   var decodedBody = jsonDecode(res.body);
// //   print(decodedBody);
// //   return decodedBody["items"];
}
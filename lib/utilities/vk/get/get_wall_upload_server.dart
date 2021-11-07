import 'dart:convert';

import '../../credentials.dart';
import 'package:http/http.dart' as http;

getWallUploadServer(String groupId) async {
  var token = await AccessToken.get();
  var res = await http.get(Uri.parse(
      'https://api.vk.com/method/photos.getWallUploadServer?group_id=$groupId&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  return decodedBody['response']['upload_url'];
}

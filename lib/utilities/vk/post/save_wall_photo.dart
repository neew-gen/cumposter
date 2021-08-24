import 'dart:convert';
import '../../credentials.dart';
import 'package:http/http.dart' as http;

saveWallPhoto(groupId, server, photo, hash) async {
  var token = await AccessToken.get();
  var res = await http.post(Uri.parse(
      'https://api.vk.com/method/photos.saveWallPhoto?group_id=$groupId&server=$server&photo=$photo&hash=$hash&access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  return decodedBody['response'][0];
}

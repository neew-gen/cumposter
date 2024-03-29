import 'dart:convert';
import '../../credentials.dart';
import 'package:http/http.dart' as http;

wallPost(groupId, text, attachments, signed, postTime) async {
  var token = await AccessToken.get();
  var attachmentsList = attachments.join(',');
  var res = await http.post(Uri.parse('https://api.vk.com/method/wall.post?'
      'owner_id=-$groupId&message=$text&'
      'attachments=$attachmentsList&signed=$signed&'
      'publish_date=$postTime&'
      'access_token=$token&v=5.131'));
  var decodedBody = jsonDecode(res.body);
  var error = decodedBody['error'];
  if (error != null) {
    if (error['error_code'] == 214) {
      return {
        'success': false,
        'errorCode': 214,
      };
    }
  } else {
    return {
      'success': true,
      'errorCode': null,
    };
  }
}

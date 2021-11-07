import 'package:sentry_flutter/sentry_flutter.dart';

import '../../credentials.dart';
import 'package:http/http.dart' as http;

deletePostponedPost(String groupId, String postId) async {
  try {
    var token = await AccessToken.get();
    var res = await http.post(Uri.parse(
        'https://api.vk.com/method/wall.delete?owner_id=-$groupId&post_id=$postId&access_token=$token&v=5.131'));
    return res;
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}

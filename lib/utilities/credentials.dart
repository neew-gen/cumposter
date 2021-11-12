import 'package:shared_preferences/shared_preferences.dart';

class AuthParams {
  static Map<String, String> getFromOauthUrl(String oauthUrl) {
    final String clearedString = oauthUrl.substring(32);
    final List<String> authParamsAsStringArray = clearedString.split('&');
    Map<String, String> authParams = {};

    for (String paramString in authParamsAsStringArray) {
      final List<String> parts = paramString.split('=');
      String paramKey = parts[0];
      String paramValue = parts[1];
      authParams[paramKey] = paramValue;
    }
    return authParams;
  }
}

class AccessToken {
  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<void> set(String? token) async {
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', token);
    }
  }
}

class UserId {
  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  static Future<void> set(String? token) async {
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', token);
    }
  }
}

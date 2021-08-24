import 'package:get/get.dart';
import 'package:vk_group_admin/screens/auth.dart';
import 'package:vk_group_admin/screens/home.dart';
import 'package:vk_group_admin/utilities/credentials.dart';

class WelcomeController extends GetxController {
  String? accessToken;
  String? userId;

  checkCredentials() async {
    await _fetchCredentials();
    if (accessToken != null && userId != null) {
      Get.off(HomeScreen());
    } else {
      Get.off(AuthScreen());
    }
  }

  _fetchCredentials() async {
    var fetchedAccessToken = await AccessToken.get();
    accessToken = fetchedAccessToken;
    var fetchedUserId = await UserId.get();
    userId = fetchedUserId;
  }
}

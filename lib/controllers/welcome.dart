import 'dart:async';

import 'package:get/get.dart';
import 'package:vk_group_admin/screens/auth.dart';
import 'package:vk_group_admin/screens/home.dart';
import 'package:vk_group_admin/utilities/credentials.dart';

import 'groups/managed.dart';

class WelcomeController extends GetxController {
  static WelcomeController get to => Get.find();
  String? accessToken;
  String? userId;

  checkCredentials() async {
    await _fetchCredentials();
    if (accessToken != null && userId != null) {
      ManagedGroupsController.to.fetchManagedGroups();
      Timer(Duration(seconds: 1), () async {
        Get.off(() => HomeScreen());
      });
    } else {
      Get.off(() => AuthScreen());
    }
  }

  _fetchCredentials() async {
    var fetchedAccessToken = await AccessToken.get();
    accessToken = fetchedAccessToken;
    var fetchedUserId = await UserId.get();
    userId = fetchedUserId;
  }
}

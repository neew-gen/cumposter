import 'dart:async';

import 'package:get/get.dart';
import 'package:cumposter/screens/auth.dart';
import 'package:cumposter/screens/home.dart';
import 'package:cumposter/utilities/credentials.dart';

import 'groups/managed.dart';

class WelcomeController extends GetxController {
  static WelcomeController get to => Get.find();
  String? accessToken;
  String? userId;

  checkCredentials() async {
    await _fetchCredentials();
    if (accessToken != null && userId != null) {
      ManagedGroupsController.to.fetchManagedGroups();
      Get.off(() => HomeScreen());
    } else {
      Get.off(() => AuthScreen());
    }
  }

  _fetchCredentials() async {
    String? fetchedAccessToken = await AccessToken.get();
    accessToken = fetchedAccessToken;
    String? fetchedUserId = await UserId.get();
    userId = fetchedUserId;
  }
}

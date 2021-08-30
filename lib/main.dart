import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/screens/welcome.dart';

import 'controllers/groups/current.dart';
import 'controllers/groups/managed.dart';
import 'controllers/options/debug.dart';
import 'controllers/postponed/create/create.dart';
import 'controllers/postponed/create/images.dart';
import 'controllers/postponed/create/time.dart';
import 'controllers/postponed/posts.dart';
import 'controllers/welcome.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This widget is the root of your application.
    // return GetMaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: WelcomeScreen(),
    // );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        initialBinding: InitialBinding(),
        // smartManagement: SmartManagement.onlyBuilder,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController(), permanent: true);
    Get.put<ManagedGroupsController>(ManagedGroupsController(), permanent: true);
    Get.put<PostponedPostsController>(PostponedPostsController(),
        permanent: true);
    Get.put<DebugController>(DebugController(), permanent: true);
    Get.put<PostponedCreateImagesController>(PostponedCreateImagesController(),
        permanent: true);
    Get.put<PostponedCreateController>(PostponedCreateController(),
        permanent: true);
    Get.put<PostponedCreateTimeController>(PostponedCreateTimeController(),
        permanent: true);
    Get.put<CurrentGroupController>(CurrentGroupController(), permanent: true);
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/screens/welcome.dart';

import 'controllers/groups/current.dart';
import 'controllers/groups/managed.dart';
import 'controllers/groups/settings.dart';
import 'controllers/options/debug.dart';
import 'controllers/postponed/create/create.dart';
import 'controllers/postponed/create/images.dart';
import 'controllers/postponed/create/options.dart';
import 'controllers/postponed/create/time.dart';
import 'controllers/postponed/posts.dart';
import 'controllers/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/color_map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
  // это работает
  // runZoned(
  //   () async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Firebase.initializeApp();
  //     runApp(App());
  //   },
  //   zoneSpecification: ZoneSpecification(
  //       print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //     DebugController.to.updateDebugConsole(line);
  //     //save to a file or do whatever you want
  //   }),
  // );
  // runZonedGuarded(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     FlutterError.dumpErrorToConsole(details);
  //     DebugController.to.updateDebugErrors(details);
  //     exit(1);
  //   };
  //   runApp(App());
  // }, (Object error, StackTrace stack) {
  //   DebugController.to.updateDebugErrors(error);
  //   exit(1);
  // });
  // runZonedGuarded(() {
  //   runApp(App());
  // }, (Object error, StackTrace stackTrace) {
  //   // Whenever an error occurs, call the `_reportError` function. This sends
  //   // Dart errors to the dev console or Sentry depending on the environment.
  //   print(123);
  //   DebugController.to.updateDebugErrors(error);
  // });
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   print(123);
  //   FlutterError.dumpErrorToConsole(details);
  //   DebugController.to.updateDebugErrors(details);
  // };
  // runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Cumposter',
        initialBinding: InitialBinding(),
        // smartManagement: SmartManagement.onlyBuilder,
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF2787F5, colorMap),
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
    Get.put<ManagedGroupsController>(ManagedGroupsController(),
        permanent: true);
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
    Get.put<GroupSettingsController>(GroupSettingsController(),
        permanent: true);
    Get.put<PostponedCreateOptionsController>(
        PostponedCreateOptionsController(),
        permanent: true);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/screens/welcome.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'controllers/groups/current.dart';
import 'controllers/groups/managed.dart';
import 'controllers/groups/settings.dart';
import 'controllers/options/debug.dart';
import 'controllers/postponed/create/create.dart';
import 'controllers/postponed/create/images/images.dart';
import 'controllers/postponed/create/images/images_path.dart';
import 'controllers/postponed/create/options.dart';
import 'controllers/postponed/create/text.dart';
import 'controllers/postponed/create/time.dart';
import 'controllers/postponed/posts.dart';
import 'controllers/unsubscribers/unsubscribers.dart';
import 'controllers/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/color_map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SentryFlutter.init(
    (postingOptions) {
      postingOptions.dsn =
          'https://717da5351764443c9b86ec57d90a112a@o1041882.ingest.sentry.io/6010841';
    },
    appRunner: () => runApp(App()),
  );
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
    PostponedCreateTextController.initialBinding();
    UnsubscribersController.initialBinding();
    PostponedCreateImagesPathController.initialBinding();
  }
}

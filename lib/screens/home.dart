import 'package:cumposter/constants/appbar_config.dart';
import 'package:cumposter/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:cumposter/controllers/groups/managed.dart';
import 'package:cumposter/widgets/home/groups_list.dart';
import 'package:get/get.dart';

import 'options.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(context) {
    ManagedGroupsController.to.fetchManagedGroups();
    return Scaffold(
      appBar: AppBar(
          title: AppbarTitle('Главное меню'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Настройки приложения',
              onPressed: () {
                Get.to(() => OptionsScreen());
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ]),
      body: HomeGroupsList(),
    );
  }
}

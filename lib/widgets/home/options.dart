import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/screens/managed_groups_menu.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/screens/options.dart';

import 'group.dart';

class HomeOptions extends StatelessWidget {
  @override
  Widget build(context) {
    final ManagedGroupsController _managedGroupsController =
        Get.put(ManagedGroupsController());
    // final CurrentGroupController _currentGroupController =
    //     Get.put(CurrentGroupController());

    _managedGroupsController.fetchManagedGroups();

    // _goToManagedGroupsMenuScreen(groupInfo) {
    //   _currentGroupController.setCurrentGroup(groupInfo);
    //   Get.to(() => ManagedGroupsMenuScreen());
    // }
    _goToOptionsPage() {
      Get.to(
        () => OptionsScreen(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _goToOptionsPage,
          child: Text('Настройки приложения'),
        )
      ],
    );
  }
}

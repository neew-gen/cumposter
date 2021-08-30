import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/screens/managed_groups_menu.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/widgets/home/groups_list.dart';
import 'package:vk_group_admin/widgets/home/options.dart';

class HomeScreen extends StatelessWidget {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          HomeGroupsList(),
          HomeOptions(),
        ],
      ),
    );
  }
}
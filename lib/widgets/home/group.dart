import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/screens/managed_groups_menu.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/screens/postponed_posts.dart';

import 'group_menu.dart';

class HomeGroupItem extends StatelessWidget {
  final _group;

  HomeGroupItem(this._group);

  @override
  Widget build(context) {
    // print(_group);
    // final ManagedGroupsController _managedGroupsController =
    //     Get.put(ManagedGroupsController());
    // final CurrentGroupController _currentGroupController =
    //     Get.put(CurrentGroupController());
    //
    // _managedGroupsController.fetchManagedGroups();

    // _goToManagedGroupsMenuScreen(groupInfo) {
    //   _currentGroupController.setCurrentGroup(groupInfo);
    //   Get.to(() => ManagedGroupsMenuScreen());
    // }

    return Card(
      child: ListTile(
        leading: Image.network(_group['photo_50']),
        title: Text(
          _group['name'],
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        onTap: () {
          CurrentGroupController.to.setCurrentGroup(_group);
          Get.to(() => PostponedPostsScreen());
        },
        trailing: HomeGroupMenu(_group),
      ),
    );
  }
}

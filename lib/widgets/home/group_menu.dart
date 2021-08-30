import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/screens/managed_groups_menu.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/screens/postponed_posts.dart';

enum NextPage { postponed }

class HomeGroupMenu extends StatelessWidget {
  final _group;

  HomeGroupMenu(this._group);
  @override
  Widget build(context) {
    // final CurrentGroupController _currentGroupController =
    //     Get.put(CurrentGroupController());
    //
    // _goToManagedGroupsMenuScreen(groupInfo) {
    //   _currentGroupController.setCurrentGroup(groupInfo);
    //   Get.to(() => ManagedGroupsMenuScreen());
    // }
    _goToNextPage(nextPage) {
      if (nextPage == NextPage.postponed) {
        CurrentGroupController.to.setCurrentGroup(_group);
        Get.to(() => PostponedPostsScreen());
      }
    }

    return PopupMenuButton<NextPage>(
      onSelected: (NextPage result) {
        _goToNextPage(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<NextPage>>[
        const PopupMenuItem<NextPage>(
          value: NextPage.postponed,
          child: Text('Отложенные записи'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/current.dart';
import 'package:vk_group_admin/models/managed_groups_model.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/screens/postponed_posts.dart';

import 'group_menu.dart';

class HomeGroupItem extends StatelessWidget {
  final ManagedGroup _group;

  HomeGroupItem(this._group);

  @override
  Widget build(context) {
    return Card(
      child: ListTile(
        leading: Image.network(_group.avatarUrl),
        title: Text(
          _group.name,
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

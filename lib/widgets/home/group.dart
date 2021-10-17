import 'package:flutter/material.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:cumposter/models/managed_groups_model.dart';
import 'package:get/get.dart';
import 'package:cumposter/screens/postponed_posts.dart';

import 'group_menu.dart';

class HomeGroupItem extends StatelessWidget {
  final ManagedGroup _group;

  HomeGroupItem(this._group);

  @override
  Widget build(context) {
    return Card(
      margin: EdgeInsets.all(2),
      child: ListTile(
        leading: Image.network(
          _group.avatarUrl,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _group.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Количество участников: ${_group.membersCount}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        // title: Text(
        //   _group.name,
        //   style: TextStyle(
        //     fontSize: 15,
        //   ),
        // ),
        onTap: () {
          CurrentGroupController.to.setCurrentGroup(_group);
          Get.to(() => PostponedPostsScreen());
        },
        trailing: HomeGroupMenu(_group),
      ),
    );
  }
}

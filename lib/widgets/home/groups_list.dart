import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/models/managed_groups_model.dart';
import 'package:get/get.dart';

import 'group.dart';

class HomeGroupsList extends StatelessWidget {
  @override
  Widget build(context) {
    ManagedGroupsController.to.fetchManagedGroups();

    return Obx(
      () => Column(children: [
        for (ManagedGroup managedGroup
            in ManagedGroupsController.to.managedGroups)
          HomeGroupItem(managedGroup),
      ]),
    );
  }
}

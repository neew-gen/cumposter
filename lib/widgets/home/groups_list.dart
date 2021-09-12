import 'package:flutter/material.dart';
import 'package:cumposter/controllers/groups/managed.dart';
import 'package:cumposter/models/managed_groups_model.dart';
import 'package:get/get.dart';

import 'group.dart';

class HomeGroupsList extends StatelessWidget {
  @override
  Widget build(context) {
    ManagedGroupsController.to.fetchManagedGroups();
    return Obx(
      () => ListView.builder(
        itemCount: ManagedGroupsController.to.managedGroups.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeGroupItem(ManagedGroupsController.to.managedGroups[index]);
        },
      ),
    );

    // return Obx(
    //   () => Column(children: [
    //     for (ManagedGroup managedGroup
    //         in ManagedGroupsController.to.managedGroups)
    //       HomeGroupItem(managedGroup),
    //   ]),
    // );
  }
}

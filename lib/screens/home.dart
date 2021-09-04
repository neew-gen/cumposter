import 'package:flutter/material.dart';
import 'package:vk_group_admin/controllers/groups/managed.dart';
import 'package:vk_group_admin/widgets/home/groups_list.dart';
import 'package:vk_group_admin/widgets/home/options.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(context) {
    ManagedGroupsController.to.fetchManagedGroups();
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
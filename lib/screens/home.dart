import 'package:flutter/material.dart';
import 'package:cumposter/controllers/groups/managed.dart';
import 'package:cumposter/widgets/home/groups_list.dart';
import 'package:cumposter/widgets/home/options.dart';

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
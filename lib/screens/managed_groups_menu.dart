import 'package:flutter/material.dart';
import 'package:cumposter/screens/postponed_posts.dart';

class ManagedGroupsMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Меню группы'),
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          ListTile(
            title: Text("Отложенные записи"),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostponedPostsScreen()),
              );
            },
          ),
        ]));
  }
}

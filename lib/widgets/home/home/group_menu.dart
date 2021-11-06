import 'package:cumposter/screens/home/group_settings.dart';
import 'package:cumposter/screens/unsubscribers/unsubscribers.dart';
import 'package:flutter/material.dart';
import 'package:cumposter/controllers/groups/current.dart';
import 'package:get/get.dart';
import 'package:cumposter/screens/postponed/postponed_posts.dart';

enum NextPage { postponed, options, unsubscribers }

class HomeGroupMenu extends StatelessWidget {
  final _group;

  HomeGroupMenu(this._group);
  @override
  Widget build(context) {
    _setCurrentGroup() {
      CurrentGroupController.to.setCurrentGroup(_group);
    }

    _goToNextPage(nextPage) {
      _setCurrentGroup();
      if (nextPage == NextPage.postponed) {
        Get.to(() => PostponedPostsScreen());
      }
      if (nextPage == NextPage.options) {
        Get.to(() => GroupSettings());
      }
      if (nextPage == NextPage.unsubscribers) {
        Get.to(() => UnsubscribersScreen());
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
        const PopupMenuItem<NextPage>(
          value: NextPage.options,
          child: Text('Настройки группы'),
        ),
        const PopupMenuItem<NextPage>(
          value: NextPage.unsubscribers,
          child: Text('Кто отписался'),
        ),
      ],
    );
  }
}

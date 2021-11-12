import 'package:cumposter/controllers/groups/settings.dart';
import 'package:cumposter/widgets/home/group_settings/start_time.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GroupSettingsController.to.fetchGroupTimeSettings();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Параметры группы'),
      ),
      body: Column(
        children: [
          GroupOptionsTime('startTime', 'Время первой записи'),
          GroupOptionsTime('endTime', 'Время последней записи'),
          GroupOptionsTime('stepTime', 'Время шага записи'),
        ],
      ),
    );
  }
}

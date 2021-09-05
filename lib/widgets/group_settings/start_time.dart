import 'package:cumposter/controllers/groups/settings.dart';
import 'package:cumposter/models/time_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupOptionsTime extends StatelessWidget {
  final String _timeType;
  final String _optionText;
  GroupOptionsTime(this._timeType, this._optionText);

  @override
  Widget build(context) {
    _getTimeString(startTime) {
      int hour = startTime?.hour ?? 0;
      int minute = startTime?.minute ?? 0;
      return '$hour:$minute';
    }

    _selectTime() async {
      var startTime = GroupSettingsController.to.postTimeSettings[_timeType];
      var hour = startTime.hour;
      var minute = startTime.minute;
      var initialTime = TimeOfDay(hour: hour!, minute: minute!);
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: 'Выберите время',
      );
      if (newTime != null) {
        GroupSettingsController.to.updateGroupTimeSettings(
            _timeType, StartTime(newTime.hour, newTime.minute));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_optionText),
              Row(
                children: [
                  TextButton(
                    onPressed: _selectTime,
                    child: Obx(
                      () => Text(
                        _getTimeString(GroupSettingsController
                            .to.postTimeSettings[_timeType]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

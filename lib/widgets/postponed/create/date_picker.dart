import 'package:cumposter/controllers/postponed/create/options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/create.dart';
import 'package:cumposter/controllers/postponed/create/time.dart';

class PostponedCreatePanelDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build date picker');
    final isInitUpdateBecauseChangeShowOptions =
        PostponedCreateOptionsController
            .to.isInitUpdateBecauseChangeShowOptions.value;
    if (!isInitUpdateBecauseChangeShowOptions) {
      PostponedCreateTimeController.to.fetchNextPostTime();
      PostponedCreateTimeController.to.fetchDateRangeString();
    }

    _getTimeString(DateTime nextPostTime) {
      final nextPostTimeToLocal = nextPostTime.toLocal();
      int hour = nextPostTimeToLocal.hour;
      int minute = nextPostTime.minute;
      return '$hour:$minute';
    }

    _getDateString(DateTime nextPostTime) {
      final nextPostTimeToLocal = nextPostTime.toLocal();
      int day = nextPostTimeToLocal.day;
      int month = nextPostTimeToLocal.month;
      int year = nextPostTimeToLocal.year;
      return '$day/$month/$year';
    }

    _selectTime() async {
      var nextPostTime = PostponedCreateTimeController.to.nextPostTime.value;
      var hour = nextPostTime.hour;
      var minute = nextPostTime.minute;
      var initialTime = TimeOfDay(hour: hour, minute: minute);
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: 'Выберите время',
      );
      if (newTime != null) {
        PostponedCreateTimeController.to
            .updateNextPostTimeHourMinute(newTime.hour, newTime.minute);
        PostponedCreateTimeController.to.fetchDateRangeString();
        PostponedCreateController.to.fetchCanCreate();
      }
    }

    void _selectDate() async {
      var nextPostTime = PostponedCreateTimeController.to.nextPostTime.value;
      var year = nextPostTime.year;
      var month = nextPostTime.month;
      var initialDate = DateTime.now();
      final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(year + 1, month),
        helpText: 'Выберите дату',
      );
      if (newDate != null) {
        PostponedCreateTimeController.to.updateNextPostTimeYearMonthDay(
            newDate.year, newDate.month, newDate.day);
        PostponedCreateTimeController.to.fetchDateRangeString();
        PostponedCreateController.to.fetchCanCreate();
      }
    }

    _refreshDate() {
      PostponedCreateTimeController.to.fetchNextPostTime();
      PostponedCreateTimeController.to.fetchDateRangeString();
      PostponedCreateController.to.fetchCanCreate();
    }

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(PostponedCreateTimeController.to.dateRangeString.value,
              style: TextStyle(
                fontSize: 13.0,
              )),
          Row(
            children: [
              TextButton(
                onPressed: _selectTime,
                child: Text(_getTimeString(
                    PostponedCreateTimeController.to.nextPostTime.value)),
              ),
              TextButton(
                onPressed: _selectDate,
                child: Text(_getDateString(
                    PostponedCreateTimeController.to.nextPostTime.value)),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: IconButton(
                  onPressed: _refreshDate,
                  icon: Icon(
                    Icons.update,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

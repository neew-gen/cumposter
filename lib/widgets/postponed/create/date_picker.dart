import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/create/create.dart';
import 'package:cumposter/controllers/postponed/create/time.dart';

class PostponedCreatePanelDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build date picker');
    PostponedCreateTimeController.to.fetchNextPostTime();
    PostponedCreateTimeController.to.fetchDateRangeString();

    _getTimeString(nextPostTime) {
      int hour = nextPostTime['hour'] ?? 0;
      int minute = nextPostTime['minute'] ?? 0;
      return '$hour:$minute';
    }

    _getDateString(nextPostTime) {
      int day = nextPostTime['day'] ?? 0;
      int month = nextPostTime['month'] ?? 0;
      int year = nextPostTime['year'] ?? 0;
      return '$day/$month/$year';
    }

    _selectTime() async {
      var nextPostTime = PostponedCreateTimeController.to.nextPostTime;
      var hour = nextPostTime['hour'];
      var minute = nextPostTime['minute'];
      var initialTime = TimeOfDay(hour: hour!, minute: minute!);
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: 'Выберите время',
      );
      if (newTime != null) {
        PostponedCreateTimeController.to.updateNextPostTime(
            {'hour': newTime.hour, 'minute': newTime.minute});
        PostponedCreateTimeController.to.fetchDateRangeString();
        PostponedCreateController.to.fetchCanCreate();
      }
    }

    void _selectDate() async {
      var nextPostTime = PostponedCreateTimeController.to.nextPostTime;
      var year = nextPostTime['year'];
      var month = nextPostTime['month'];
      var initialDate = DateTime.now();
      final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(year + 1, month),
        helpText: 'Выберите дату',
      );
      if (newDate != null) {
        PostponedCreateTimeController.to.updateNextPostTime(
            {'year': newDate.year, 'month': newDate.month, 'day': newDate.day});
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
                child: Text(_getTimeString(PostponedCreateTimeController.to.nextPostTime)),
              ),
              TextButton(
                onPressed: _selectDate,
                child: Text(_getDateString(PostponedCreateTimeController.to.nextPostTime)),
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

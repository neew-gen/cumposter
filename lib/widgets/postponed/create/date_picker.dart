import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/create/create.dart';
import 'package:vk_group_admin/controllers/postponed/create/time.dart';

class PostponedCreatePanelDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PostponedCreateTimeController _postponedAddTimeController =
        Get.put(PostponedCreateTimeController());
    final PostponedCreateController _postponedCreateController =
        Get.put(PostponedCreateController());

    _postponedAddTimeController.fetchNextPostTime();
    _postponedAddTimeController.fetchDateRangeString();

    _getTimeString() {
      var nextPostTime = _postponedAddTimeController.nextPostTime;
      int hour = nextPostTime['hour'] ?? 0;
      int minute = nextPostTime['minute'] ?? 0;
      return '$hour:$minute';
    }

    _getDateString() {
      var nextPostTime = _postponedAddTimeController.nextPostTime;
      int day = nextPostTime['day'] ?? 0;
      int month = nextPostTime['month'] ?? 0;
      int year = nextPostTime['year'] ?? 0;
      return '$day/$month/$year';
    }

    _selectTime() async {
      var nextPostTime = _postponedAddTimeController.nextPostTime;
      var hour = nextPostTime['hour'];
      var minute = nextPostTime['minute'];
      var initialTime = TimeOfDay(hour: hour!, minute: minute!);
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: 'Выберите время',
      );
      if (newTime != null) {
        _postponedAddTimeController.updateNextPostTime(
            {'hour': newTime.hour, 'minute': newTime.minute});
        _postponedAddTimeController.fetchDateRangeString();
        _postponedCreateController.fetchCanCreate();
      }
    }

    void _selectDate() async {
      var nextPostTime = _postponedAddTimeController.nextPostTime;
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
        _postponedAddTimeController.updateNextPostTime(
            {'year': newDate.year, 'month': newDate.month, 'day': newDate.day});
        _postponedAddTimeController.fetchDateRangeString();
        _postponedCreateController.fetchCanCreate();
      }
    }

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_postponedAddTimeController.dateRangeString.value,
              style: TextStyle(
                fontSize: 13.0,
              )),
          // Column(
          //   children: [
          //     Text(
          //       'Дата записи: ',
          //       style: TextStyle(
          //         fontSize: 12.0,
          //       ),
          //     ),
          //     Text(_postponedAddTimeController.dateRangeString.value,
          //         style: TextStyle(
          //           fontSize: 13.0,
          //         )),
          //   ],
          // ),
          Row(
            children: [
              TextButton(
                onPressed: _selectTime,
                child: Text(_getTimeString()),
              ),
              TextButton(
                onPressed: _selectDate,
                child: Text(_getDateString()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class PostponedAddDatePicker extends StatefulWidget {
//   final Map<String, int> nextPostTime;
//   final String dateRangeString;
//
//   const PostponedAddDatePicker(
//       {Key? key, required this.nextPostTime, required this.dateRangeString})
//       : super(key: key);
//   @override
//   _PostponedAddDatePickerState createState() => _PostponedAddDatePickerState();
// }
//
// class _PostponedAddDatePickerState extends State<PostponedAddDatePicker> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       PostponedAddTimeProvider provider =
//           Provider.of<PostponedAddTimeProvider>(context, listen: false);
//
//       provider.fetchNextPostTime();
//       provider.fetchDateRangeString();
//     });
//   }
//
//   _getTimeString() {
//     Map<String, int> nextPostTime = widget.nextPostTime;
//     int hour = nextPostTime['hour'] ?? 0;
//     int minute = nextPostTime['minute'] ?? 0;
//     return '$hour:$minute';
//   }
//
//   _getDateString() {
//     Map<String, int> nextPostTime = widget.nextPostTime;
//     int day = nextPostTime['day'] ?? 0;
//     int month = nextPostTime['month'] ?? 0;
//     int year = nextPostTime['year'] ?? 0;
//     return '$day/$month/$year';
//   }
//
//   void _selectTime() async {
//     var nextPostTime = widget.nextPostTime;
//     var hour = nextPostTime['hour'];
//     var minute = nextPostTime['minute'];
//     var initialTime = TimeOfDay(hour: hour!, minute: minute!);
//     final TimeOfDay? newTime = await showTimePicker(
//       context: context,
//       initialTime: initialTime,
//       helpText: 'Выберите время',
//     );
//     if (newTime != null) {
//       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//         PostponedAddTimeProvider provider =
//             Provider.of<PostponedAddTimeProvider>(context, listen: false);
//
//         provider.updateNextPostTime(
//             {'hour': newTime.hour, 'minute': newTime.minute});
//       });
//     }
//   }
//
//   void _selectDate() async {
//     var nextPostTime = widget.nextPostTime;
//     var year = nextPostTime['year'];
//     var month = nextPostTime['month'];
//     var day = nextPostTime['day'];
//     var initialDate = DateTime(year!, month!, day!);
//     final DateTime? newDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: initialDate,
//       lastDate: DateTime(year + 1, month),
//       helpText: 'Выберите дату',
//     );
//     if (newDate != null) {
//       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//         var postponedAddTimeProvider =
//             Provider.of<PostponedAddTimeProvider>(context, listen: false);
//
//         postponedAddTimeProvider.updateNextPostTime(
//             {'year': newDate.year, 'month': newDate.month, 'day': newDate.day});
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text('Следующая запись: '),
//         Text(widget.dateRangeString),
//         TextButton(
//           onPressed: _selectTime,
//           child: Text(_getTimeString()),
//         ),
//         TextButton(
//           onPressed: _selectDate,
//           child: Text(_getDateString()),
//         ),
//       ],
//     );
//     // return Consumer<PostponedTimeProvider>(
//     //     builder: (context, postponedTimeProvider, child) {
//     //   return CustomPicker(
//     //       {currentTime: postponedTimeProvider.nextPostTime, locale: 'ru'});
//     // });
//   }
// }

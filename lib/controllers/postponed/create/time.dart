import 'package:cumposter/controllers/groups/settings.dart';
import 'package:cumposter/models/time_models.dart';
import 'package:cumposter/utilities/next_post_time/get_date_range.dart';
import 'package:get/get.dart';
import 'package:cumposter/controllers/postponed/posts.dart';

class PostponedCreateTimeController extends GetxController {
  static PostponedCreateTimeController get to => Get.find();
  //
  // final StartTime _startTime = StartTime(6, 30);
  // final EndTime _endTime = EndTime(21, 30);
  // final StepTime _step = StepTime(1, 0);

  Rx<DateTime> nextPostTime = DateTime.now().obs;
  void fetchNextPostTime() {
    var postponedPosts = PostponedPostsController.to.postponedPosts;
    var startTime = GroupSettingsController.to.postTimeSettings['startTime'];
    var endTime = GroupSettingsController.to.postTimeSettings['endTime'];
    var stepTime = GroupSettingsController.to.postTimeSettings['stepTime'];
    var nextPostTimeInMs =
        _getNextPostTimeInMs(postponedPosts, startTime, endTime, stepTime);
    print(DateTime.fromMillisecondsSinceEpoch(nextPostTimeInMs));
    nextPostTime.value = DateTime.fromMillisecondsSinceEpoch(nextPostTimeInMs);
  }

  void updateNextPostTimeHourMinute(hour, minute) {
    final currentNextPostTime = nextPostTime.value;
    nextPostTime.value = DateTime(currentNextPostTime.year,
        currentNextPostTime.month, currentNextPostTime.day, hour, minute);
  }

  void updateNextPostTimeYearMonthDay(year, month, day) {
    final currentNextPostTime = nextPostTime.value;
    nextPostTime.value = DateTime(
        year, month, day, currentNextPostTime.hour, currentNextPostTime.minute);
  }

  var dateRangeString = ''.obs;
  void fetchDateRangeString() {
    dateRangeString.value = getDateRange(nextPostTime.value);
  }

  Map<String, int> _formatNextPostTime(DateTime dateTime) {
    var year = dateTime.year;
    var month = dateTime.month;
    var day = dateTime.day;
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    return {
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute
    };
  }

  _getNextPostTimeInMs(
      posts, PostTime startTime, PostTime endTime, PostTime step) {
    var nowInMs = DateTime.now().millisecondsSinceEpoch;
    var todayStartTimeInMs =
        _getTodayTimeInMs(startTime.hour, startTime.minute);
    var todayEndTimeInMs = _getTodayTimeInMs(endTime.hour, endTime.minute);
    var stepTimeInMs = _getMsFromHoursAndMinutes(step.hour, step.minute);
    return _findNextPostTime(
      posts,
      nowInMs,
      stepTimeInMs,
      todayStartTimeInMs,
      todayStartTimeInMs,
      todayEndTimeInMs,
    );
  }

  _findNextPostTime(posts, now, step, startEveryDay, start, end) {
    bool isPostExistInTime = _getPostExistInTime(posts, start);
    // если дата поста равна дате конца постинга, возвращаем
    if (start == end && isPostExistInTime == false && start > now) {
      return start;
    }
    // если дата поста больше времени конца постинга в этот день,
    // переходим на следующий день
    if (start > end) {
      const msInDay = 86400000;
      var nextDayStart = startEveryDay + msInDay;
      // если когда мы перешли на следующий день, дата начала меньше, и нет записи
      // возвращаем результат
      if (start > nextDayStart && isPostExistInTime == false) {
        return start;
      }
      int nextDayEnd = end + msInDay;
      return _findNextPostTime(
          posts, now, step, nextDayStart, nextDayStart, nextDayEnd);
      // если время сейчас больше чем дата начала постинга, или есть запись, делаем шаг
    } else if (now > start || isPostExistInTime) {
      return _findNextPostTime(
        posts,
        now,
        step,
        startEveryDay,
        start + step,
        end,
      );
      // если время сейчас меньше чем время старта, ставим время сейчас равное старту
    } else if (now < start) {
      return _findNextPostTime(posts, start, step, startEveryDay, start, end);
      // если особые условия не выполнены, возвращаем запись
    } else {
      return start;
    }
  }

  bool _getPostExistInTime(posts, time) {
    var findResult =
        posts.where((post) => post['date'] * 1000 == time).toList();
    if (findResult == null) {
      return false;
    }
    return findResult.isNotEmpty;
  }

  int? _getMsFromHoursAndMinutes(int hour, int minute) {
    int ms = 0;

    ms += hour * 3600000;
    ms += minute * 60000;
    return ms;
  }

  int _getTodayTimeInMs(int hour, int minute) {
    var date = DateTime.now();
    var year = date.year;
    var month = date.month;
    var day = date.day;
    return DateTime(year, month, day, hour, minute).millisecondsSinceEpoch;
  }
}

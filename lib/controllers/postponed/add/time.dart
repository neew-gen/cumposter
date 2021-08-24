import 'package:get/get.dart';
import 'package:vk_group_admin/controllers/postponed/posts.dart';

class PostponedAddTimeController extends GetxController {
  final Map<String, int> _startTime = {
    'hour': 6,
    'minute': 30,
  };
  final Map<String, int> _endTime = {
    'hour': 21,
    'minute': 30,
  };
  final Map<String, int> _step = {
    'hour': 1,
    'minute': 0,
  };

  var nextPostTime = {}.obs;
  void fetchNextPostTime() {
    final PostponedPostsController _postponedPostsController =
        Get.put(PostponedPostsController());

    var _postponedPosts = _postponedPostsController.postponedPosts;
    var nextPostTimeInMs =
        _getNextPostTimeInMs(_postponedPosts, _startTime, _endTime, _step);
    nextPostTime.value = _formatNextPostTime(
        DateTime.fromMillisecondsSinceEpoch(nextPostTimeInMs));
  }

  void updateNextPostTime(Map<String, int> fieldsForUpdate) {
    fieldsForUpdate.forEach((k, v) => nextPostTime[k] = v);
  }

  var dateRangeString = ''.obs;
  void fetchDateRangeString() {
    DateTime now = DateTime.now();
    if (now.year == nextPostTime['year']) {
      if (now.month == nextPostTime['month']) {
        if (now.day == nextPostTime['day']) {
          dateRangeString.value = 'Сегодня';
        } else if (nextPostTime['day']! - now.day == 1) {
          dateRangeString.value = 'Завтра';
        } else if (nextPostTime['day']! - now.day == 2) {
          dateRangeString.value = 'Послезавтра';
        } else {
          int dayRange = nextPostTime['day']! - now.day;
          dateRangeString.value = 'Через $dayRange дня(ей)';
        }
      } else {
        int monthRange = nextPostTime['month']! - now.month;
        dateRangeString.value = 'Через $monthRange месяца(ов)';
      }
    } else {
      int yearRange = nextPostTime['year']! - now.year;
      dateRangeString.value = 'Через $yearRange год(а)';
    }
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

  _getNextPostTimeInMs(posts, startTime, endTime, step) {
    var nowInMs = DateTime.now().millisecondsSinceEpoch;
    var todayStartTimeInMs =
        _getTodayTimeInMs(startTime['hour'], startTime['minute']);
    var todayEndTimeInMs = _getTodayTimeInMs(endTime['hour'], endTime['minute']);
    var stepTimeInMs = _getMsFromHoursAndMinutes(step['hour'], step['minute']);
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

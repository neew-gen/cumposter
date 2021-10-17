String getDateRange(postTime) {
  DateTime now = DateTime.now();
  final differenceBetweenDates = postTime.difference(now);
  final differenceInDays = differenceBetweenDates.inDays;
  switch (differenceInDays) {
    case 0:
      return 'Сегодня';
    case 1:
      return 'Завтра';
    case 2:
      return 'Послезавтра';
    case 3:
      return 'Через 3 дня';
    case 4:
      return 'Через 4 дня';
    default:
      return 'Через $differenceInDays дней';
  }
  return '$differenceInDays';
  // if (now.year == postTime['year']) {
  //   if (now.month == postTime['month']) {
  //     if (now.day == postTime['day']) {
  //       return 'Сегодня';
  //     } else if (postTime['day']! - now.day == 1) {
  //       return 'Завтра';
  //     } else if (postTime['day']! - now.day == 2) {
  //       return 'Послезавтра';
  //     } else {
  //       int dayRange = postTime['day']! - now.day;
  //       return 'Через $dayRange дня(ей)';
  //     }
  //   } else {
  //     return '';
  //   }
  // } else {
  //   return '';
  // }
}

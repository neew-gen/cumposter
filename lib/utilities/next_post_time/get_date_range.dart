String getDateRange(postTime) {
  DateTime now = DateTime.now();
  final nowOnlyDate = DateTime(now.year, now.month, now.day);
  final postTimeOnlyDate =
      DateTime(postTime.year, postTime.month, postTime.day);
  final differenceBetweenDates = postTimeOnlyDate.difference(nowOnlyDate);
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
}

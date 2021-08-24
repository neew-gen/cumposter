formatTimeFromUnixToMapType(unixTime) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
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

formatMapTypeToUnix(time) {
  var dateInMs = DateTime(time['year'], time['month'], time['day'],
          time['hour'], time['minute'])
      .millisecondsSinceEpoch;
  return dateInMs ~/ 1000;
}

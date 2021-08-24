getNowMapType() {
  var now = DateTime.now();
  return {
    'year': now.year,
    'month': now.month,
    'day': now.day,
    'hour': now.hour,
    'minute': now.minute,
  };
}

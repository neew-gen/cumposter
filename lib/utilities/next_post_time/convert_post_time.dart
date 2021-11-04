import 'package:cumposter/models/time_models.dart';

convertMapToPostTime(mapForConvert) {
  var result = {};
  mapForConvert.forEach(
      (key, value) => {result[key] = PostTime(value['hour'], value['minute'])});
  return result;
}

convertPostTimeToMap(postTimeMapToConvert) {
  var result = {};
  postTimeMapToConvert.forEach((key, value) => {result[key] = value.toMap()});
  return result;
}

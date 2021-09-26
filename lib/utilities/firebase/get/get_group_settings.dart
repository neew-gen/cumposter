import 'package:cumposter/models/time_models.dart';

import '../../credentials.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getPostTimeSettings(groupId) async {
  String? userId = await UserId.get();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCol = firestore.collection('users');
  var userDoc = usersCol.doc(userId);
  CollectionReference groupsCol = userDoc.collection('groups');
  var groupDoc = groupsCol.doc(groupId);
  CollectionReference settingsCol = groupDoc.collection('settings');
  DocumentSnapshot<Object?> startTimeSnap =
      await settingsCol.doc('startTime').get();

  Map<String, dynamic>? startTimeData =
      startTimeSnap.data() as Map<String, dynamic>?;
  StartTime startTime = StartTime(6, 30);
  if (startTimeData == null) {
    settingsCol.doc('startTime').set({'hour': 6, 'minute': 30});
  } else {
    startTime.hour = startTimeData['hour'];
    startTime.minute = startTimeData['minute'];
  }

  DocumentSnapshot<Object?> endTimeSnap =
      await settingsCol.doc('endTime').get();
  Map<String, dynamic>? endTimeData =
      endTimeSnap.data() as Map<String, dynamic>?;
  EndTime endTime = EndTime(21, 30);
  if (endTimeData == null) {
    settingsCol.doc('endTime').set({'hour': 21, 'minute': 30});
  } else {
    endTime.hour = endTimeData['hour'];
    endTime.minute = endTimeData['minute'];
  }

  DocumentSnapshot<Object?> stepTimeSnap =
      await settingsCol.doc('stepTime').get();
  Map<String, dynamic>? stepTimeData =
      stepTimeSnap.data() as Map<String, dynamic>?;
  StepTime stepTime = StepTime(1, 0);
  if (stepTimeData == null) {
    settingsCol.doc('stepTime').set({'hour': 1, 'minute': 0});
  } else {
    stepTime.hour = stepTimeData['hour'];
    stepTime.minute = stepTimeData['minute'];
  }

  return {'startTime': startTime, 'endTime': endTime, 'stepTime': stepTime};
}

getShowOptions(groupId) async {
  String? userId = await UserId.get();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCol = firestore.collection('users');
  var userDoc = usersCol.doc(userId);
  CollectionReference groupsCol = userDoc.collection('groups');
  var groupDoc = groupsCol.doc(groupId);
  CollectionReference settingsCol = groupDoc.collection('settings');

  DocumentSnapshot<Object?> isShowOptionsSnap =
  await settingsCol.doc('isShowOptions').get();
  Map<String, dynamic>? isShowOptionsData =
  isShowOptionsSnap.data() as Map<String, dynamic>?;
  bool isShowOptions = false;
  if (isShowOptionsData == null) {
    settingsCol.doc('isShowOptions').set({'isShowOptions': false});
  } else {
    isShowOptions = isShowOptionsSnap['isShowOptions'];
  }

  return isShowOptions;
}

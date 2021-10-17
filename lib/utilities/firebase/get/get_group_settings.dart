import 'package:cumposter/controllers/groups/current.dart';
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
  PostTime startTime = PostTime(6, 30);
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
  PostTime endTime = PostTime(21, 30);
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
  PostTime stepTime = PostTime(1, 0);
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

Future<List> getAllGroupSettings() async {
  final CollectionReference settingsColRef = await _getSettingsColRef();
  QuerySnapshot querySnapshot = await settingsColRef.get();
  return querySnapshot.docs
      .map((doc) => {'id': doc.id, 'value': doc.data()})
      .toList();
}

CollectionReference _getUsersColRef() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference usersCol = firestore.collection('users');
  return usersCol;
}

CollectionReference _getGroupsColRef(userId) {
  final CollectionReference usersCol = _getUsersColRef();
  final DocumentReference userDoc = usersCol.doc(userId);
  final CollectionReference groupsCol = userDoc.collection('groups');
  return groupsCol;
}

Future<CollectionReference> _getSettingsColRef() async {
  final String? userId = await UserId.get();
  final String? groupId = CurrentGroupController.to.currentGroup.value.id;
  final CollectionReference groupsCol = _getGroupsColRef(userId);
  final DocumentReference groupDoc = groupsCol.doc(groupId);
  final CollectionReference settingsCol = groupDoc.collection('settings');
  return settingsCol;
}

import 'package:cumposter/controllers/groups/current.dart';

import '../../credentials.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

updatePostTimeSettings(groupId, settingName, settingValue) async {
  String? userId = await UserId.get();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('users')
      .doc(userId)
      .collection('groups')
      .doc(groupId)
      .collection('settings')
      .doc(settingName)
      .update(settingValue.toMap());
}

updateShowOptionsInFirebase(groupId, newValue) async {
  String? userId = await UserId.get();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('users')
      .doc(userId)
      .collection('groups')
      .doc(groupId)
      .collection('settings')
      .doc('isShowOptions')
      .update({'isShowOptions': newValue});
}

updateGroupParam(id, value) async {
  final String? groupId = CurrentGroupController.to.currentGroup.value.id;
  String? userId = await UserId.get();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('users')
      .doc(userId)
      .collection('groups')
      .doc(groupId)
      .collection('settings')
      .doc(id)
      .update(value);
}

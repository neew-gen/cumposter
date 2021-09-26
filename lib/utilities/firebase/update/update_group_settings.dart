import 'package:cumposter/models/time_models.dart';

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

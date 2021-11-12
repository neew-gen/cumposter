import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class FirebaseProvider {
  static getDocData(colPath, docId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection(colPath);
      DocumentSnapshot<Object?> documentSnapshot =
          await collectionReference.doc(docId).get();
      final data = documentSnapshot.data();
      return data;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  static checkDocIsExist(colPath, docId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection(colPath);
      DocumentSnapshot<Object?> documentSnapshot =
          await collectionReference.doc(docId).get();
      return documentSnapshot.exists;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  static getColData(colPath) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection(colPath);
      QuerySnapshot querySnapshot = await collectionReference.get();
      var result = {};
      for (var doc in querySnapshot.docs) {
        result[doc.id] = doc.data();
      }
      return result;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  static setDocData(String colPath, String docId, dynamic dataForUpdate) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var convertedMap = Map<String, dynamic>.from(dataForUpdate);
      await firestore.doc(colPath + '/' + docId).set(convertedMap);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  static updateDocData(
      String colPath, String docId, dynamic dataForUpdate) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var convertedMap = Map<String, dynamic>.from(dataForUpdate);
      await firestore.doc(colPath + '/' + docId).update(convertedMap);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}

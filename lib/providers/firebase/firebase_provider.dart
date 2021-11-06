import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  static getDocData(colPath, docId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionReference = firestore.collection(colPath);

    DocumentSnapshot<Object?> documentSnapshot =
        await collectionReference.doc(docId).get();

    final data = documentSnapshot.data();
    return data;
  }
  static checkDocIsExist(colPath, docId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print(colPath);

    CollectionReference collectionReference = firestore.collection(colPath);

    DocumentSnapshot<Object?> documentSnapshot =
    await collectionReference.doc(docId).get();

    return documentSnapshot.exists;
  }

  static getColData(colPath) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionReference = firestore.collection(colPath);

    QuerySnapshot querySnapshot = await collectionReference.get();
    var result = {};
    for (var doc in querySnapshot.docs) {
      result[doc.id] = doc.data();
    }
    return result;
  }

  static setDocData(String colPath, String docId, dynamic dataForUpdate) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var convertedMap = Map<String, dynamic>.from(dataForUpdate);
    await firestore.doc(colPath + '/' + docId).set(convertedMap);
  }

  static updateDocData(
      String colPath, String docId, dynamic dataForUpdate) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var convertedMap = Map<String, dynamic>.from(dataForUpdate);
    await firestore.doc(colPath + '/' + docId).update(convertedMap);
  }
}

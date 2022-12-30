import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper{

  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchNoteData() {
    return fireStore.collection('note').snapshots();
  }

  Future<DocumentReference> insertNoteData(
      {required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>> documentReference = await fireStore
        .collection('note').add(data);

    return documentReference;
  }

  Future<void> updateNoteData(
      {required Map<String, dynamic> data, required String id}) async {
    await fireStore.collection('note').doc(id).update(data);
  }

  Future<void> deleteNoteData({required String id}) async {
    await fireStore.collection('note').doc(id).delete();
  }



}
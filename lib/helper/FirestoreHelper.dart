import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper{

  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchAuthorData() {
    return fireStore.collection('author').snapshots();
  }

  Future<DocumentReference> insertAuthorData(
      {required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>> documentReference = await fireStore
        .collection('author').add(data);

    return documentReference;
  }

  Future<void> updateAuthorData(
      {required Map<String, dynamic> data, required String id}) async {
    await fireStore.collection('author').doc(id).update(data);
  }

  Future<void> deleteAuthorData({required String id}) async {
    await fireStore.collection('author').doc(id).delete();
  }



}
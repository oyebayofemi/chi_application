import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  var taskcollections = FirebaseFirestore.instance.collection('customers');
  var pendingcollections = FirebaseFirestore.instance.collection('quote');

  Future deleteQuote(String documentSnapshotID) async {
    return await pendingcollections
        .doc(uid)
        .collection('pending')
        .doc(documentSnapshotID)
        .delete();
  }
}

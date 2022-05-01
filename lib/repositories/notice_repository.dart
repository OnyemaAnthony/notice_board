import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeRepository{


  Stream<QuerySnapshot> getAllNotice(String parishID) {
    try {
      return FirebaseFirestore.instance.collection('Users').where('isVisible',isEqualTo: true)
          .snapshots();
    } catch (e) {
     return throw Exception(e.toString());
    }
  }

}
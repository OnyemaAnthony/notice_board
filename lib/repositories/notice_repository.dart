import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notice_board/models/notice_model.dart';

class NoticeRepository{


  Stream<QuerySnapshot> getAllNotice() {
    try {
      return FirebaseFirestore.instance.collection('notices').where('isVisible',isEqualTo: true)
          .snapshots();
    } catch (e) {
     return throw Exception(e.toString());
    }
  }

  Future<void> saveNotice(NoticeModel notice)async{
    try {
      await FirebaseFirestore.instance.collection('notices').add(notice.toMap());
    } catch (e) {
      print(e.toString());
    }
  }
 Future<void>deleteNotice(String noticeId)async{
    try {
      await FirebaseFirestore.instance.collection('notices').doc(noticeId).delete();
    } catch (e) {
      print(e.toString());
    }
 }
}
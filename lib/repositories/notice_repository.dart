import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/utilities.dart';

class NoticeRepository {
  Stream<QuerySnapshot> getAllNotice() {
    try {
      return FirebaseFirestore.instance
          .collection('notices')
          .where('isVisible', isEqualTo: false)
          .snapshots();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> fetchPublishersNotice(String publishersId) {
    try {
      return FirebaseFirestore.instance
          .collection('notices')
          .where('createdBy', isEqualTo: publishersId)
          .where('isVisible', isEqualTo: false)
          .snapshots();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  Future<void> saveNotice(NoticeModel notice) async {
    try {
      await FirebaseFirestore.instance
          .collection('notices')
          .add(notice.toMap());
      Utilities.showToast('Notice saved');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteNotice(String noticeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notices')
          .doc(noticeId)
          .delete();
      Utilities.showToast('Notice Deleted');
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/utilities.dart';

class NoticeRepository {
  Stream<QuerySnapshot> getAllNotice() {
    try {
      return FirebaseFirestore.instance
          .collection('Notices')
          .where('isVisible', isEqualTo: true)
          .orderBy('createdAt',descending: true)
          .snapshots();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }
  Future<void> approveNotice(
      String noticeId, Map<String, dynamic> notice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Notices')
          .doc(noticeId)
          .update(notice);
      Utilities.showToast("Notice approved");
    } catch (e) {
    }
  }
  Stream<QuerySnapshot> fetchPublishersNotice(String publishersId) {
    try {
      return FirebaseFirestore.instance
          .collection('Notices')
          .where('createdBy', isEqualTo: publishersId)
          .where('isVisible', isEqualTo: true)
          .snapshots();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }
  Stream<QuerySnapshot>fetchNoticeRequest(){
    try{
      return FirebaseFirestore.instance.collection('Notices').where('isVisible',isEqualTo: false).snapshots();
    }catch(e){
      return throw Exception(e.toString());
    }
  }

  Future<void> saveNotice(NoticeModel notice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Notices')
          .add(notice.toMap());
      Utilities.showToast('Notice saved');
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> deleteNotice(String noticeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Notices')
          .doc(noticeId)
          .delete();
      Utilities.showToast('Notice Deleted');
    // ignore: empty_catches
    } catch (e) {
    }
  }

  Future<String> uploadNoticePicture(
      File file, String userId, String folderName) async {
    try{
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(folderName)
          .child(userId)
          .putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    }catch(e){
      print('the error is ${e.toString()}');

    }
    return'';

  }
}
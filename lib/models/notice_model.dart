import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String? id;
  String? title;
  String? description;
  String? createdBy;
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? updatedAt;

  NoticeModel({
    this.id,
    this.title,
    this.description,
    this.createdBy,
    this.deadline,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdBy': createdBy,
      'deadline': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
    };
  }

  NoticeModel.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> notice)
      : id = notice.id,
        title = notice.data()['title'],
        description = notice.data()['description'],
        createdBy = notice.data()['createdBy'],
        deadline = notice.data()['deadline'].toDate(),
        createdAt = notice.data()['createdAt'].toDate(),
        updatedAt = notice.data()['updatedAt'].toDate();
}

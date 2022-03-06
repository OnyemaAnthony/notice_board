import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String? id;
  String? title;
  String? description;
  String? createdBy;
  bool? isVisible;
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? updatedAt;

  NoticeModel({
    this.id,
    this.title,
    this.description,
    this.isVisible,
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
      'isVisible':isVisible,
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
        isVisible = notice.data()['isVisible'],
        deadline = notice.data()['deadline'].toDate(),
        createdAt = notice.data()['createdAt'].toDate(),
        updatedAt = notice.data()['updatedAt'].toDate();
}

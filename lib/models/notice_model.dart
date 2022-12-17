import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String? id;
  String? title;
  String? description;
  String? createdBy;
  String? createdByPicture;
  String? createdByFullName;
  String? imageURL;
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
    this.createdByFullName,
    this.createdByPicture,
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
      'createdByFullName':createdByFullName,
      'createdByPicture':createdByPicture,
      'deadline': deadline,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
    };
  }

  NoticeModel.fromFireStore(dynamic notice)
      : id = notice.id,
        title = notice.data()['title'],
        description = notice.data()['description'],
        createdBy = notice.data()['createdBy'],
        isVisible = notice.data()['isVisible'],
        createdByPicture = notice.data()['createdByPicture'],
        createdByFullName = notice.data()['createdByFullName'],
        imageURL = notice.data()!['imageURL'],
        deadline =  notice.data()['deadline'].toDate() ?? DateTime.now(),
        createdAt = notice.data()['createdAt'].toDate() ?? DateTime.now(),
        updatedAt = notice.data()['updatedAt'].toDate() ?? DateTime.now();
}

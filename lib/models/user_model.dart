import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? imageURL;
  String? description;
  bool? isAdmin;
  bool? isPublisher;
  DateTime? createdAt;
  DateTime? updatedAt;


  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.imageURL,
    this.description,
    this.isAdmin,
    this.isPublisher,
    this.createdAt,
    this.updatedAt});


  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'imageURL': imageURL,
      'description': description,
      'isAdmin': isAdmin,
      'isPublisher': isPublisher,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> notice):
       id = notice.id,
      firstName= notice.data() ['firstName'],
      lastName =notice.data() ['lastName'],
      imageURL =notice.data() ['imageURL'],
      description =notice.data() ['description'],
      isAdmin =notice.data() ['isAdmin'],
      isPublisher =notice.data() ['isPublisher'],
      createdAt =notice.data() ['createdAt'].toDate(),
      updatedAt =notice.data() ['updatedAt'].toDate();

  }

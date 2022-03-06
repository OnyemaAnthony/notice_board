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

  UserModel.fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> user):
       id = user.id,
      firstName= user.data() ['firstName'],
      lastName =user.data() ['lastName'],
      imageURL =user.data() ['imageURL'],
      description =user.data() ['description'],
      isAdmin =user.data() ['isAdmin'],
      isPublisher =user.data() ['isPublisher'],
      createdAt =user.data() ['createdAt'].toDate(),
      updatedAt =user.data() ['updatedAt'].toDate();

  }

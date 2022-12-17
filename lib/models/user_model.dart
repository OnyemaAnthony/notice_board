import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? imageURL;
  String? description;
  String? phoneNumber;
  bool? isAdmin;
  bool? isRequestedPublisher;
  bool? isPublisher;
  String? gender;
  DateTime? dob;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.imageURL,
      this.description,
        this.phoneNumber,
      this.isAdmin,
      this.isPublisher,
      this.isRequestedPublisher,
      this.createdAt,
        this.gender,
        this.dob,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'imageURL': imageURL,
      'email': email,
      'description': description,
      'phoneNumber':phoneNumber,
      'isAdmin': isAdmin,
      'isRequestedPublisher': isRequestedPublisher,
      'isPublisher': isPublisher,
      'dob': dob,
      'gender':gender,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserModel.fromFireStore(dynamic user)
      : id = user.id,
        firstName = user.data()!['firstName'],
        lastName = user.data()!['lastName'],
        imageURL = user.data()!['imageURL'],
        email = user.data()!['email'],
        description = user.data()!['description'],
        phoneNumber= user.data()!['phoneNumber'],
        isAdmin = user.data()!['isAdmin'],
        isRequestedPublisher = user.data()!['isRequestedPublisher'],
        isPublisher = user.data()!['isPublisher'],
        dob = user.data()!['dob'].toDate(),
         gender = user.data()!['gender'],
        createdAt = user.data()!['createdAt']?.toDate(),
        updatedAt = user.data()!['updatedAt']?.toDate();
}

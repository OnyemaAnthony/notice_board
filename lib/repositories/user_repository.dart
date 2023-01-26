import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notice_board/utilities.dart';
import '../models/user_model.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<UserModel> getUser() async {
    String userID = (firebaseAuth!.currentUser)!.uid;
    return (await getUserInfo(userID));
  }

  Future<User?> signUpUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      Utilities.showToast(e.toString());
      throw Exception(e);
    }
  }

  Future<User?> logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      Utilities.showToast(e.toString());
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth!.signOut();
  }

  bool? isSignedIn() {
    var currentUser = firebaseAuth!.currentUser;
    return currentUser != null;
  }

  User? getCurrentUser() {
    return firebaseAuth!.currentUser;
  }

  Future<void> updateUserToPublisher(
      String userId, Map<String, dynamic> user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update(user);
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> rejectPublishersRequest(
      String userId, Map<String, dynamic> user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveUser(UserModel user, String userUID) async {
    try {
      if (!await userDetailExist(userUID)) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userUID)
            .set(user.toMap());
      }
    } catch (e) {
      Utilities.showToast(e.toString());
      throw Exception(e);
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      return snapshot.docs
          .map((user) => UserModel.fromFireStore(user))
          .toList();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> fetchPublishersRequest() {
    try {
      return FirebaseFirestore.instance
          .collection('Users')
          .where('isPublisher', isEqualTo: false)
          .where('isRequestedPublisher', isEqualTo: true)
          .snapshots();
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  Future<UserModel> getUserInfo(String userID) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    return UserModel.fromFireStore(userDoc);
  }

  Future<bool> userDetailExist(String userID) async {
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    return user.exists;
  }

  Future<void> saveUserToFireStore(UserModel user, String userUID) async {
    try {
      if (!(await userDetailExist(userUID))) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userUID)
            .set(user.toMap());
      }
    } catch (e) {
      Utilities.showToast(e.toString());
    }
  }

  Future<String> uploadProfilePicture(
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
  Future<void>forgetPassword(String email)async{
    try{
      print('started');
      await firebaseAuth!.sendPasswordResetEmail(email: email);
      Utilities.showToast("Please check your email we sent a reset password link for you to reset you account");
    }catch(e){
      print(e.toString());
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notice_board/utilities.dart';

import '../models/user_model.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }
  Future<UserModel> getUser() async {
    String userID = ( firebaseAuth!.currentUser)!.uid;
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

  Future<void> saveUser(UserModel user, String userUID) async {
    try {
      if (!await userDetailExist(userUID)) {
        await FirebaseFirestore.instance.collection('Users').doc(userUID).set(user.toMap());
      }
    } catch (e) {
      Utilities.showToast(e.toString());
      throw Exception(e);
    }
  }
  Future<UserModel> getUserInfo(String userID) async {
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    return UserModel.fromFireStore(userDoc);
  }
  Future<bool> userDetailExist(String userID)async {
    DocumentSnapshot user =
    await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    return user.exists;
  }

}
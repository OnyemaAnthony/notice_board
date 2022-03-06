import 'package:firebase_auth/firebase_auth.dart';
import 'package:notice_board/utilities.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
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

  Future<void> saveDoctor(doctor, String userUID) async {
    try {
      if (!await userDetailExist(userUID)) {
        await DatabaseReference.doctorsRef.doc(userUID).set(doctor.toMap());
      }
    } catch (e) {
      print(e.toString());
      Utilities.showToast(e.toString());
      throw Exception(e);
    }
  }


}
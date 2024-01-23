// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  late String? uid;
  late String? me;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser!;

  //Login
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  //register

  Future createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      uid = user.uid;
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignOut

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //UserExists
  Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user!.uid).get()).exists;
  }

  // get data of mine

  Future myInfo(snapshot) async {
    return await firestore
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) => {});
  }
}

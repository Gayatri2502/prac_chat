import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';

import '../Authentication/auth_form.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //Login
  //register

  Future createUserWithEmailAndPassword(
      String email, String password, ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password, ))
          .user!;

      if (user != null) {
        AuthForm(uid: user.uid);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  //SignOut
}

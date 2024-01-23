// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:prac_chat/Widgets/Authentication/login.dart";

import "../Models/user_model.dart";

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key, required this.currentUser}) : super(key: key);
  UserModel currentUser;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //final _auth = FirebaseAuth.instance;

  // Future<void> _submitAuthForm(String userName, String userEmail,
  //     String userPassword, bool isLogin, BuildContext ctx) async {
  //   UserCredential authResult;
  //   try {
  //     if (isLogin) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       authResult = await _auth.signInWithEmailAndPassword(
  //           email: "", password: "password");
  //     } else {
  //       authResult = await _auth.createUserWithEmailAndPassword(
  //           email: "email", password: "password");
  //       await FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(authResult.user!.uid)
  //           .set({
  //         'username': userName,
  //         'password': userPassword,
  //         'Email': userEmail,
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     var message = "An Occurred, please check your credentials!";
  //     if (e.message != null) {
  //       message = e.message!;
  //     }
  //     ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      body: const LogIn(),
    );
  }
}

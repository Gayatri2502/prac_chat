import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/textfield_decoration.dart';
import '../../Screens/home_screen.dart';
import '../Services/auth_services.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    this.uid,
  });

  final String? uid;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  bool isLoading = false;

  AuthServices authServices = AuthServices();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController =
      TextEditingController();

  Future<void> saveSubmit() async {
    /*final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }*/
    print("Save Submit");
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _userEmailController.text,
            password: _userPasswordController.text)
        .then((value) async {
      print("User Added");
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_userEmailController.text)
          .set({
        "Name": _userNameController.text,
        "Email": _userEmailController.text,
        "Password": _userPasswordController.text,
        "PhoneNumber": _userPhoneNumberController.text
      }).then((value) {
        print("User Added to Database");
      });
    });
  }

  // create() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await authServices
  //         .createUserWithEmailAndPassword(_userName, _userPhoneNumber,
  //             _userEmail, _userPassword, _userConfirmPassword)
  //         .then((value) async {
  //       if (value == true) {
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(_userEmail);
  //         await HelperFunctions.saveUserNameSF(_userName);
  //         // nextScreenReplace(context, const HomeScreen());
  //
  //
  //       } else {
  //         showSnackbar(context, Colors.red, value);
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.teal.shade900,
            ),
          )
        : Center(
            child: Card(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      padding: MediaQuery.of(context).padding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                              width: 200,
                              height: 100,
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdk3Lps9LHjj879CMHkAMdwSI49f2FRyWixXkEbSw2JA&usqp=CAU&ec=48665699")),
                          const SizedBox(height: 20),
                          if (!_isLogin)
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'User Name',
                                  prefixIcon: const Icon(Icons.person),
                                  prefixIconColor: Colors.black),
                              controller: _userNameController,
                            ),
                          const SizedBox(
                            height: 15,
                          ),

                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            validator: (value) {
                              return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value!)
                                  ? null
                                  : "Please Enter a valid E-mail Address";
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Email address',
                              prefixIcon: const Icon(Icons.mail),
                              prefixIconColor: Colors.black,
                            ),
                            controller: _userEmailController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (!_isLogin)
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.length != 10) {
                                    return ("Enter valid phone number ");
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Phone number',
                                    prefixIcon: const Icon(Icons.call),
                                    prefixIconColor: Colors.black),
                                controller: _userPhoneNumberController),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.length >= 8) {
                                return ("Entered Password is Invalid ");
                              } else {
                                return RegExp(
                                            r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                        .hasMatch(value)
                                    ? null
                                    : "Please use Strong Password";
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'password',
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: Colors.black),
                            controller: _userPasswordController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (!_isLogin)
                            TextFormField(
                                validator: (value) {
                                  if (value != _userPasswordController.text) {
                                    return ("Entered Password do not match");
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Confirm password',
                                    prefixIcon: const Icon(Icons.lock),
                                    prefixIconColor: Colors.black),
                                controller: _userConfirmPasswordController),

                          // if (isLoading)
                          ElevatedButton(
                              onPressed: () {
                                print("On Pressed Called");
                                saveSubmit().then((value) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeScreen();
                                  }));
                                });
                                // create();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade900,
                              ),
                              child: Text(_isLogin ? "LogIn" : "SignUp")),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                  _isLogin
                                      ? "Create a new account"
                                      : "I already have an account",
                                  style: const TextStyle(
                                      color: Colors.teal, fontSize: 16))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

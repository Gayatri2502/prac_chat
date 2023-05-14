import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/textfield_decoration.dart';
import '../../Screens/home_screen.dart';
import '../Services/auth_services.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    this.uid,
    //required this.currentUser
  });
  //UserModel currentUser;
  final String? uid;

  @override
  State<SignUp> createState() => _AuthFormState();
}

class _AuthFormState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  AuthServices authServices = AuthServices();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController =
      TextEditingController();

  String? _errorMessage;

  Future<void> saveSubmit() async {
    // if (_formKey.currentState!.validate()) {

    print("Save Submit");

    setState(() {
      _isLoading = true;
    });

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _userEmailController.text,
            password: _userPasswordController.text)
        .then((value) async {
      print("User Added");
      // generate a new UUID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(value.user!.uid)
          .set({
        "userID": value.user!.uid,
        "Name": _userNameController.text,
        "Email": _userEmailController.text,
        "Password": _userPasswordController.text,
        "PhoneNumber": _userPhoneNumberController.text
      }).then((value) {
        print("User Added to Database");

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      });
    });
    // }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                          TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  _errorMessage = 'Value cannot be empty ';
                                });
                              } else if (value.length < 3) {
                                setState(() {
                                  _errorMessage =
                                      'Name must be more than 3 character';
                                });
                              }
                              return " ";
                            },
                            decoration: textInputDecoration.copyWith(
                                errorText: _errorMessage,
                                labelText: 'User Name',
                                prefixIcon: const Icon(Icons.person),
                                prefixIconColor: Colors.black),
                            controller: _userNameController,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              final emailRegExpression =
                                  RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (value!.isEmpty) {
                                setState(() {
                                  _errorMessage = ' Value Cannot be Empty';
                                });
                              } else if (!emailRegExpression.hasMatch(value)) {
                                setState(() {
                                  _errorMessage = 'Invalid Email Address';
                                });
                              }
                              return '';
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              errorText: _errorMessage,
                              labelText: 'Email address',
                              prefixIcon: const Icon(Icons.mail),
                              prefixIconColor: Colors.black,
                            ),
                            controller: _userEmailController,
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _errorMessage = 'Value Cannot be Empty';
                                  });
                                } else if (value.length != 10) {
                                  setState(() {
                                    _errorMessage = 'Invalid Phone Number';
                                  });
                                }
                                return '';
                              },
                              keyboardType: TextInputType.phone,
                              decoration: textInputDecoration.copyWith(
                                  errorText: _errorMessage,
                                  labelText: 'Phone number',
                                  prefixIcon: const Icon(Icons.call),
                                  prefixIconColor: Colors.black),
                              controller: _userPhoneNumberController),
                          const SizedBox(height: 10),

                          TextFormField(
                            validator: (value) {
                              final passRegExpression = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                              if (value!.length >= 8) {
                                setState(() {
                                  _errorMessage = "Password is too Short";
                                });
                              } else if (!passRegExpression.hasMatch(value)) {
                                setState(() {
                                  _errorMessage = 'Password is Weak';
                                });
                              }
                              return '';
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                errorText: _errorMessage,
                                labelText: 'password',
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: Colors.black),
                            controller: _userPasswordController,
                          ),
                          const SizedBox(height: 10),

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
                                  errorText: _errorMessage,
                                  labelText: 'Confirm password',
                                  prefixIcon: const Icon(Icons.lock),
                                  prefixIconColor: Colors.black),
                              controller: _userConfirmPasswordController),
                          const SizedBox(height: 25),

                          // if (isLoading)
                          ElevatedButton(
                              onPressed: () {
                                print("On Pressed Called");
                                saveSubmit();
                                //
                                // await saveSubmit()
                                //     .then((value) {
                                //   showDialog(
                                //     context: context,
                                //     builder: (context) => const Center(
                                //       child: CircularProgressIndicator(
                                //         value: 0.8,
                                //         valueColor:
                                //             AlwaysStoppedAnimation<Color>(
                                //                 Colors.teal),
                                //       ),
                                //     ),
                                //     barrierDismissible: false,
                                //   );
                                //
                                //
                                // });
                                // create();
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(150, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.teal.shade900),
                              ),
                              child: const Text('SignUp')),

                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return LogIn();
                                }));
                              },
                              child: const Text("I already have an account",
                                  style: TextStyle(
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

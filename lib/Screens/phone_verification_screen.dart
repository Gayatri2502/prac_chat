// ignore_for_file: avoid_print, unused_field

import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/textfield_decoration.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({
    super.key,
    this.uid,
  });

  final String? uid;

  @override
  State<PhoneVerificationScreen> createState() => _AuthFormState();
}

class _AuthFormState extends State<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _otpTapped = false;
  final bool _isLoading = false;
  final _text = '';

  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    const SizedBox(height: 70),
                    const Text(
                        " We have send Verification code to your phone number. "),
                    const SizedBox(height: 10),
                    TextFormField(
                      // validator: (value) {
                      //   value = _userEmailController.text;
                      //   final emailRegExpression = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                      //   if (_touched && value.isEmpty) {
                      //     return 'Value cannot be empty';
                      //   } else if (_touched && !emailRegExpression.hasMatch(value)) {
                      //     return 'Invalid email address';
                      //   }
                      //   return null;
                      // },
                      onTap: () {
                        setState(() {
                          _otpTapped = true;
                        });
                      },

                      keyboardType: TextInputType.number,
                      decoration: textInputDecoration.copyWith(
                        // errorText: _errorTextEmail,
                        labelText: 'Enter your OTP ',
                        prefixIcon: const Icon(Icons.phone_iphone),
                        prefixIconColor: Colors.black,
                      ),
                      controller: _otpController,
                      onChanged: (text) => setState(() => _text),
                    ),

                    const SizedBox(
                      height: 60,
                    ),
                    // if (_isLoading)
                    ElevatedButton(
                        onPressed: () async {
                          print("On Pressed Called");
                          try {} on FirebaseAuthException catch (e) {
                            print(
                                "Failed to sign in with email and password: ${e.message}");
                            Future<void> showAlertDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Invalid phone number or password',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            "${e.message}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            return showAlertDialog();

                            // handle error
                          }

                          // create();
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.teal.shade900),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(color: Colors.white),
                        )),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.of(context)
                    //           .push(MaterialPageRoute(builder: (context) {
                    //         return const SignUp();
                    //       }));
                    //     },
                    //     child: const Text("Create a new account",
                    //         style:
                    //             TextStyle(color: Colors.teal, fontSize: 16))),
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

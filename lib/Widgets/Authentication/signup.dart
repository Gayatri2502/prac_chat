import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/textfield_decoration.dart';
import '../../Screens/home_screen.dart';
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
  bool _nameTapped = false;
  bool _emailTapped = false;
  bool _phoneNoTapped = false;
  bool _passwordTapped = false;
  bool _confirmPasswordTapped = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController =
      TextEditingController();

  var text = '';

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
    _userPhoneNumberController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  String? get _errorTextEmail {
    @override
    void initState() {
      super.initState();
    }

    final emailText = _userEmailController.value.text;
    final emailRegExpression = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_emailTapped && emailText.isEmpty) {
      return " can't be empty ";
    }
    if (_emailTapped && !emailRegExpression.hasMatch(emailText)) {
      return 'Invalid E-mail Address';
    }
    return null;
    // return null if text is valid
  }

  String? get _errorTextName {
    @override
    void initState() {
      super.initState();
    }

    final nameText = _userNameController.value.text;

    if (_nameTapped && nameText.length < 5) {
      return 'Name is too Short !';
    }
    return null;
  }

  String? get _errorTextPhoneNumber {
    @override
    void initState() {
      super.initState();
    }

    final phoneText = _userPhoneNumberController.value.text;
    if (_phoneNoTapped && phoneText.isEmpty) {
      return "value can't be empty";
    }
    if (_phoneNoTapped && phoneText.length != 10) {
      return ' Invalid Phone Number';
    }
    return null;
  }

  String? get _errorTextPassword {
    @override
    void initState() {
      super.initState();
    }

    final passText = _userPasswordController.value.text;
    final passRegExpression = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (_passwordTapped && passText.isEmpty) {
      return "Value can't be empty";
    }
    if (_passwordTapped && !passRegExpression.hasMatch(passText)) {
      return 'Invalid Password';
    }
    if (_passwordTapped && passText.length < 4) {
      return " Password is too Short !";
    }
    return null;
  }

  String? get _errorTextConfirmPassword {
    @override
    void initState() {
      super.initState();
    }

    final confirmPassText = _userConfirmPasswordController.value.text;
    final passText = _userPasswordController.value.text;

    if (_confirmPasswordTapped && confirmPassText.isEmpty) {
      return "Re-type your Password";
    }
    if (_confirmPasswordTapped && confirmPassText != passText) {
      return 'Password did not Match';
    }
    return null;
  }

  Future<void> saveSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print("Save Submit");

      if (isValid) {

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
            setState(() {
              _isLoading = false;
            });
          });
        });
      }

    }
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
                            onTap: () {
                              setState(() {
                                _emailTapped = false;
                                _passwordTapped = false;
                                _confirmPasswordTapped = false;
                                _phoneNoTapped = false;
                                _nameTapped = true;
                              });
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     setState(() {
                            //       _errorMessage = 'Value cannot be empty ';
                            //     });
                            //   } else if (value.length < 3) {
                            //     setState(() {
                            //       _errorMessage =
                            //           'Name must be more than 3 character';
                            //     });
                            //   }
                            //   return " ";
                            // },
                            decoration: textInputDecoration.copyWith(
                                errorText: _errorTextName,
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person),
                                prefixIconColor: Colors.black),
                            controller: _userNameController,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            // validator: (value) {
                            //   final emailRegExpression =
                            //       RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                            //   if (value!.isEmpty) {
                            //     setState(() {
                            //       _errorMessage = ' Value Cannot be Empty';
                            //     });
                            //   } else if (!emailRegExpression.hasMatch(value)) {
                            //     setState(() {
                            //       _errorMessage = 'Invalid Email Address';
                            //     });
                            //   }
                            //   return '';
                            // },
                            keyboardType: TextInputType.emailAddress,
                            onTap: () {
                              setState(() {
                                _nameTapped = false;
                                _emailTapped = true;
                                _passwordTapped = false;
                                _confirmPasswordTapped = false;
                                _phoneNoTapped = false;
                              });
                            },
                            decoration: textInputDecoration.copyWith(
                              errorText: _errorTextEmail,
                              labelText: 'Email address',
                              prefixIcon: const Icon(Icons.mail),
                              prefixIconColor: Colors.black,
                            ),
                            controller: _userEmailController,
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     setState(() {
                              //       _errorMessage = 'Value Cannot be Empty';
                              //     });
                              //   } else if (value.length != 10) {
                              //     setState(() {
                              //       _errorMessage = 'Invalid Phone Number';
                              //     });
                              //   }
                              //   return '';
                              // },
                              onTap: () {
                                setState(() {
                                  _emailTapped = false;
                                  _nameTapped = false;
                                  _passwordTapped = false;
                                  _confirmPasswordTapped = false;
                                  _phoneNoTapped = true;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: textInputDecoration.copyWith(
                                  errorText: _errorTextPhoneNumber,
                                  labelText: 'Phone number',
                                  prefixIcon: const Icon(Icons.call),
                                  prefixIconColor: Colors.black),
                              controller: _userPhoneNumberController),
                          const SizedBox(height: 10),

                          TextFormField(
                            // validator: (value) {
                            //   final passRegExpression = RegExp(
                            //       r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                            //   if (value!.length >= 8) {
                            //     setState(() {
                            //       _errorMessage = "Password is too Short";
                            //     });
                            //   } else if (!passRegExpression.hasMatch(value)) {
                            //     setState(() {
                            //       _errorMessage = 'Password is Weak';
                            //     });
                            //   }
                            //   return '';
                            // },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            onTap: () {
                              setState(() {
                                _passwordTapped = true;
                                _emailTapped = false;
                                _nameTapped = false;
                                _confirmPasswordTapped = false;
                                _phoneNoTapped = false;
                              });
                            },
                            decoration: textInputDecoration.copyWith(
                                errorText: _errorTextPassword,
                                labelText: 'password',
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: Colors.black),
                            controller: _userPasswordController,
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                              // validator: (value) {
                              //   if (value != _userPasswordController.text) {
                              //     return ("Entered Password do not match");
                              //   }
                              //   return null;
                              // },
                              onTap: () {
                                setState(() {
                                  _confirmPasswordTapped = true;
                                  _emailTapped = false;
                                  _passwordTapped = false;
                                  _nameTapped = false;
                                  _phoneNoTapped = false;
                                });
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  errorText: _errorTextConfirmPassword,
                                  labelText: 'Confirm password',
                                  prefixIcon: const Icon(Icons.lock),
                                  prefixIconColor: Colors.black),
                              controller: _userConfirmPasswordController),
                          const SizedBox(height: 25),

                          // if (isLoading)
                          ElevatedButton(
                              onPressed: () async {
                                print("On Pressed Called");
                                try {
                                  await saveSubmit().then((value) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const LogIn();
                                    }));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print(
                                      "Failed to sign in with email and password: ${e.message}");
                                  Future<void> _showAlertDialog() async {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          // <-- SEE HERE
                                          title: const Text(
                                              'Error in Authentication -- '),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text("${e.message}"),
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

                                  return _showAlertDialog();

                                  // handle error
                                }

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
                                  return const LogIn();
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

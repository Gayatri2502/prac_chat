import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Constants/web_parameters.dart';
import 'package:prac_chat/Screens/chat_screen.dart';
import 'package:prac_chat/Screens/welcome_screen.dart';
import 'package:prac_chat/Widgets/Chat/new_message.dart';

import '../Functions/helper_functions.dart';
import '../Screens/home_screen.dart';
import 'Chat/message.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: WebConstants.apiKey,
            appId: WebConstants.appId,
            messagingSenderId: WebConstants.messagingSenderId,
            projectId: WebConstants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() {
    HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp',
        home : WelcomeScreen()
    );
  }
}

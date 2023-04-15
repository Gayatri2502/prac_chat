import 'package:flutter/material.dart';
import 'package:prac_chat/Constants/fonts.dart';
import 'package:prac_chat/Screens/auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal.shade900,
        child: SizedBox(
            child: Column(
          children: [
            Padding(
              padding: MediaQuery.of(context).padding,
              child: Text(
                'Welcome to WhatsApp',
                style: CustomizedTextStyle.regular,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              height: 380,
              width: 300,
              decoration: const BoxDecoration(
                  // color: Colors.teal,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://mytraining.global/app/uploads/2021/07/Icon-Comp.png'))),
            ),
            Padding(
                padding: MediaQuery.of(context).padding,
                child: Text(
                  "Read our Privacy Policy Tap Agree and continue to accept the Terms of Services ",
                  style: CustomizedTextStyle.welcome,
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AuthScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // set the circular radius
                  ),
                ),
                child: Text(
                  "AGREE AND CONTINUE",
                  style: CustomizedTextStyle.medium,
                ))
          ],
        )),
      ),
    );
  }
}

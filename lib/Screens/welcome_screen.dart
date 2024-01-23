import 'package:flutter/material.dart';
import 'package:prac_chat/Constants/fonts.dart';
import 'package:prac_chat/Widgets/Authentication/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);
  // UserModel user;
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
            child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: MediaQuery.of(context).padding,
              child: Text(
                'Welcome to WhatsApp',
                style: CustomizedTextStyle.regular,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              height: 350,
              width: 300,
              decoration: const BoxDecoration(
                  // color: Colors.teal,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://mytraining.global/app/uploads/2021/07/Icon-Comp.png'))),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_box_outline_blank_sharp,
                      color: Colors.white70,
                    )),
                const SizedBox(
                  height: 40,
                  width: 270,
                  child: Text(
                    "Read our Privacy Policy Tap Agree and continue to accept the Terms of Services ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const LogIn();
                  }));
                },
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.teal.shade100,
                //   shape: RoundedRectangleBorder(
                //
                //     borderRadius: BorderRadius.circular(15),
                //     // set the circular radius
                //   ),
                // ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.tealAccent.shade400),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(260, 50)),
                ),
                child: const Text("AGREE & CONTINUE",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      // fontFamily: 'Roboto-Bold',
                      color: Colors.black,
                      // fontStyle: FontStyle.normal,
                      // letterSpacing: 1,
                      // wordSpacing: 2.0,
                    )))
          ],
        )),
      ),
    );
  }
}

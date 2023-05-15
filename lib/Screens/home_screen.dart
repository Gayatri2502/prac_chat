import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Screens/call_screen.dart';
import 'package:prac_chat/Screens/camera_screen.dart';
import 'package:prac_chat/Screens/profile_screen.dart';
import 'package:prac_chat/Screens/status_screen.dart';
import 'package:prac_chat/Widgets/Chat%20Cards/chat_cards.dart';

import '../Constants/fonts.dart';
import '../Models/user_model.dart';
import 'chat_card_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomeScreen({
    Key? key, required this.cameras,
  }) : super(key: key);
  //UserModel currentUser ;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFab = true;


  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }



  // @override
  // void initState() {
  //   super.initState();
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     firestore.collection('Users').doc(user.uid).get().then((documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //
  //         currentUser = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  //         setState(() {});
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.teal.shade800,
                title: Text("WhatsApp"),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (
                          context,
                        ) {
                          return ProfileScreen();
                        }));
                      },
                      icon: const Icon(Icons.camera_alt_outlined, size: 25)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      )),
                  PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                              SizedBox(width: 25),
                              Text("New group ",
                                  style: CustomizedTextStyle.bold),
                            ],
                          ),
                          onTap: () {}),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.broadcast_on_personal_sharp,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text("New broadcast ",
                                style: CustomizedTextStyle.bold),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.link,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Linked devices ",
                              style: CustomizedTextStyle.bold,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.payment,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Payments ",
                              style: CustomizedTextStyle.bold,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text("Settings", style: CustomizedTextStyle.bold),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ];
                  })
                ],
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  tabs: const <Widget>[
                    Tab(icon: Icon(Icons.camera_alt)),
                    Tab(text: "CHATS"),
                    Tab(
                      text: "STATUS",
                    ),
                    Tab(
                      text: "CALLS",
                    ),
                  ],
                ),
                // PreferredSize(
                //   preferredSize: const Size.fromHeight(15),
                //   child: SizedBox(
                //     height: 40,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         Row(
                //           children: [
                //             GestureDetector(
                //               onTap: () {
                //                 // Handle item tap
                //               },
                //               child: Container(
                //                 width: 80,
                //                 height: 40,
                //                 decoration: const BoxDecoration(
                //                   border: Border(
                //                       bottom: BorderSide(
                //                           width: 2, color: Colors.greenAccent)),
                //                 ),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: const [
                //                     Icon(Icons.groups, color: Colors.white),
                //                     SizedBox(width: 15),
                //                     // Text('Home', style: TextStyle(fontSize: 16)),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 // Handle item tap
                //               },
                //               child: SizedBox(
                //                 width: 100,
                //                 height: 40,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: const [
                //                     SizedBox(width: 25),
                //                     Text('Chats',
                //                         style: TextStyle(
                //                             fontSize: 16, color: Colors.white)),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 // Handle item tap
                //               },
                //               child: SizedBox(
                //                 width: 100,
                //                 height: 40,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: const [
                //                     SizedBox(width: 40),
                //                     Text('Status',
                //                         style: TextStyle(
                //                             fontSize: 16, color: Colors.white)),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 // Handle item tap
                //               },
                //               child: SizedBox(
                //                 width: 100,
                //                 height: 40,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: const [
                //                     SizedBox(width: 55),
                //                     Text('Calls',
                //                         style: TextStyle(
                //                             fontSize: 16, color: Colors.white)),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                CameraScreen(widget.cameras),
                const ChatCardScreen(),
                const StatusScreen(),
                const CallsScreen(),
              ],

            ),
            floatingActionButton: showFab ? FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('')
                    .add({'text': 'This was added by clicking the button'});
              },
              child: const Icon(Icons.add),
            ): null ,
          );

  }
}

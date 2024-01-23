import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Screens/call_screen.dart';
import 'package:prac_chat/Screens/group_screen.dart';
import 'package:prac_chat/Screens/profile_screen.dart';
import 'package:prac_chat/Screens/status_screen.dart';

import 'chat_card_screen.dart';
import 'new_group_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({
    Key? key,
    required this.cameras,
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
          title: const Text(
            "WhatsApp",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const GroupCardScreen();
                  // }));
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 25,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  color: Colors.white,
                  Icons.search,
                  size: 25,
                )),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: PopupMenuButton(
                  iconColor: Colors.white,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                              SizedBox(width: 25),
                              Text(
                                "New group ",
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const NewGroupScreen();
                            }));
                          }),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.broadcast_on_personal_sharp,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "New broadcast ",
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Linked devices ",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Payments ",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (
                              context,
                            ) {
                              return const ProfileScreen();
                            }));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Settings",
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ];
                  }),
            )
          ],
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            tabs: const <Widget>[
              Tab(
                  icon: Icon(
                Icons.groups,
              )),
              Tab(text: "Chats"),
              Tab(
                text: "updates",
              ),
              Tab(
                text: "calls",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          GroupCardScreen(),
          ChatCardScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('')
                    .add({'text': 'This was added by clicking the button'});
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

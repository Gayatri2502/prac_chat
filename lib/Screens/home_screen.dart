import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constants/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.teal.shade800,
          title: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "WhatsApp",
                    textAlign: TextAlign.left,
                  )),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
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
                        SizedBox(width: 10),
                        Text("New group ", style: CustomizedTextStyle.bold),
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
                      Text("New broadcast ", style: CustomizedTextStyle.bold),
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(15),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle item tap
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Colors.greenAccent)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.groups, color: Colors.white),
                              SizedBox(width: 5),
                              // Text('Home', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle item tap
                        },
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(width: 5),
                              Text('Chats',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle item tap
                        },
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(width: 5),
                              Text('Status',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle item tap
                        },
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(width: 5),
                              Text('Calls',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          FirebaseFirestore.instance
              .collection('')
              .add({'text': 'This was added by clicking the button'});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

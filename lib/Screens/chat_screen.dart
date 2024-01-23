// ignore_for_file: must_be_immutable

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:prac_chat/Models/user_model.dart";
import "package:prac_chat/Widgets/Chat/new_message.dart";

import "../Models/message_model.dart";
import "../Widgets/Chat/message.dart";

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.user}) : super(key: key);
  UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String channelId = createChannelId(
        FirebaseAuth.instance.currentUser!.uid, widget.user.userID);
    // String currentUser =FirebaseAuth.instance.currentUser!.uid;

    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal.shade800,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 1,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                backgroundImage: NetworkImage(''),
                //backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu5FZuFGnw61FjM4bhIq97AXB2BexZZa145Df1oP9t5w&usqp=CAU&ec=48665699'),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            title: Text(
              widget.user.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam_rounded,
                    size: 30,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call,
                    size: 25,
                    color: Colors.white,
                  )),
              PopupMenuButton(
                  iconColor: Colors.white,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.contact_page_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "View contact",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.perm_media_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Media,links and docs",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(Icons.volume_mute_rounded,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              "Mute notifications",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.message_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Disappearing messages",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.wallpaper_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Wallpaper",
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(Icons.expand_more_rounded,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              "More",
                            ),
                          ],
                        ),
                        onTap: () {
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              const PopupMenuItem(child: Text("Report")),
                              const PopupMenuItem(child: Text("Block")),
                              const PopupMenuItem(child: Text("Clear chat")),
                              const PopupMenuItem(child: Text("Export chat")),
                              const PopupMenuItem(child: Text("Add shortcut"))
                            ];
                          });
                        },
                      )
                    ];
                  })
            ],
          ),
          body: Stack(
            children: [
              Image.asset(
                'assets/wallpaper.png', // Replace with your image asset path
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.brown.shade100
                    .withOpacity(0.5), // Adjust opacity for a lighter effect
                colorBlendMode: BlendMode.darken,
              ),
              Column(
                children: [
                  Expanded(
                      child: Messages(
                    channelId: channelId,
                  )),
                  NewMessages(channelId: channelId)
                ],
              ),
            ],
          )

          //
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("images/wallpaper.jpg"),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       Expanded(
          //           child: Messages(
          //         channelId: channelId,
          //       )),
          //       NewMessages(channelId: channelId)
          //     ],
          //   ),
          // ),
          );
    });
  }
}

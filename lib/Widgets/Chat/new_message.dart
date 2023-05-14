import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Models/message_model.dart';
import 'package:uuid/uuid.dart';

import '../../Models/user_model.dart';

class NewMessages extends StatefulWidget {
  final String channelId;

  NewMessages({Key? key, required this.channelId}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  late DateTime date;




  void _sendMessage(MessageModel mesg) async {
    FocusScope.of(context).unfocus();

    print("mesg is being added");

    await FirebaseFirestore.instance
        .collection("Chatting-Channel")
        .doc(widget.channelId)
        .collection("Messages")
        .doc(mesg.mesgId)
        .set(mesg.toJson());
    _controller.clear();
  }

  //Collection "Chats"
  //Doc "Channel id"
  //Collection "Messages"
  //Doc "Message Id"
  //set(MessageModel.toJson)
  //MessgeModel
  /*String id, String message, String? imagelink, UserModel sender, DateTime sentat, List<UserModel> readBy*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.emoji_emotions_outlined,
                    color: Colors.black),
                hintText: 'Send a message.....         ',
                hintTextDirection: TextDirection.ltr,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                suffixIcon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                )),
          )),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.insert_link_rounded)),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.currency_rupee_rounded)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) {
                  UserModel currentUser =
                      UserModel.fromJson(jsonDecode(jsonEncode(value.data())));
                  var uuid = const Uuid();
                  var newMesgID = uuid.v4();
                  _sendMessage(MessageModel(
                    mesgId: newMesgID,
                    message: _controller.text,
                    imageLink: '',
                    sentAt: DateTime.now(),
                    sentBy: currentUser,
                    seenBy: [currentUser],
                  ));
                });
              },
              icon: const Icon(
                Icons.send,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}

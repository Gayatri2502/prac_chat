import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Models/message_model.dart';

import 'message_bubble.dart';

class Messages extends StatefulWidget {
  Messages({Key? key, required this.channelId}) : super(key: key);
  final String channelId;
  List<MessageModel> mesg = [];

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chatting-Channel')
          .doc(widget.channelId)
          .collection("Messages").orderBy('sentAt',descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (!chatSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;

        List<MessageModel> messages = [];
        for (var i = 0; i < chatDocs.length; i++) {
          var message = MessageModel.fromJson(
              jsonDecode(jsonEncode(chatDocs[i].data())));
          messages.add(message);
        }

        return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (ctx, index) => MessageBubble(
                message: messages[index].message,
                isMe: messages[index].sentBy.userID == FirebaseAuth.instance.currentUser!.uid,
            ));
      },
    );
  }
}

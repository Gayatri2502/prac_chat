import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessage = " ";
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('Chats').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid
    });
    _controller.clear();
  }

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
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.insert_link_rounded)),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.currency_rupee_rounded)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          IconButton(
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () {
                      _sendMessage();
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

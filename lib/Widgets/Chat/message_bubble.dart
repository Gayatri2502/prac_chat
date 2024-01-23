// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.teal.shade100 : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomLeft: isMe ? Radius.circular(15.0) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(15.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 250, // Set your specific limit here
                ),
                child: Text(
                  message,
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {Key? key, required this.message, required this.isMe,})
      : super(key: key);

  final String message;
  bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
            width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
                color: isMe ? Colors.black87 : Colors.teal.shade200,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(25),
                    bottomRight: isMe
                        ? const Radius.circular(12)
                        : const Radius.circular(0))),
            child: Text(message,
                style: TextStyle(color: isMe ? Colors.teal : Colors.black))),
      ],
    );
  }
}

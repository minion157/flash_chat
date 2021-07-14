import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({this.sender = '', this.text = '', required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.blueGrey, fontSize: 12),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(7) : Radius.circular(1),
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
                topRight: isMe ? Radius.circular(1) : Radius.circular(7)),
            elevation: 2.0,
            color: isMe ? Colors.teal : Color(0xFF262D31),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;

class MessagesStream extends StatelessWidget {
  const MessagesStream({required this.loggedInUser});
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        String messageText;
        String messageSender;
        for (var message in messages) {
          messageText = message.get('text');
          messageSender = message.get('sender');
          final currentUser = loggedInUser.email;
          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }

  static sendMessage(String messageText, User loggedInUser) {
    _fireStore.collection('messages').add(
      {
        'text': messageText,
        'sender': loggedInUser.email,
        'time': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }
}

// return Expanded(
//   child: ListView.builder(
//       reverse: false,
//       itemCount: snapshot.data!.docs.length,
//       itemBuilder: (context, index) {
//         return MessageBubble(
//           isMe: loggedInUser.email ==
//               snapshot.data!.docs[index].get('sender'),
//           sender: snapshot.data!.docs[index].get('sender'),
//           text: snapshot.data!.docs[index].get('text'),
//         );
//       }),
// );

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  final String? name;
  final String? uId;

  Messages({super.key, this.name, this.uId});

  final userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBubble(
            message: chatDocs[index]['text'],
            isMe: chatDocs[index]['userId'] == userId!.uid,
            username: chatDocs[index]['username'],
            sellerName: name!,
            // isSell: chatDocs[index]['sellerId'] == uId,
            // myKey: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}

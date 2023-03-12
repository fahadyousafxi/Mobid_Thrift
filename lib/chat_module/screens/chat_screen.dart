import 'package:flutter/material.dart';

import '../../ui/appbar/My_appbar.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_messages.dart';

class ChatScreen extends StatefulWidget {
  final String? uId;
  final String? name;

  const ChatScreen({super.key, this.uId, this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Future<void> deleteAll() async {
  //   final collection =
  //       await FirebaseFirestore.instance.collection("chat").get();
  //
  //   final batch = FirebaseFirestore.instance.batch();
  //
  //   for (final doc in collection.docs) {
  //     batch.delete(doc.reference);
  //   }
  //
  //   return batch.commit();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),

      // AppBar(
      //   title: const Text('Chat Screen'),
      //   actions: [
      //     DropdownButton(
      //       elevation: 0,
      //       underline: Container(),
      //       borderRadius: BorderRadius.circular(16),
      //       dropdownColor: Colors.pinkAccent,
      //       icon: Icon(
      //         Icons.more_vert,
      //         color: Theme.of(context).primaryIconTheme.color,
      //       ),
      //       items: [
      //         DropdownMenuItem(
      //           value: 'clear',
      //           child: Row(
      //             children: const [
      //               Icon(
      //                 Icons.clear_all,
      //                 color: Colors.white,
      //               ),
      //               SizedBox(
      //                 width: 8,
      //               ),
      //               Text(
      //                 'Clear Chat',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //       onChanged: (value) {
      //         if (value == 'clear') {
      //           deleteAll();
      //         }
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: Messages(
              name: widget.name,
              uId: widget.uId,
              key: widget.key,
            ),
          ),
          NewMessages(
            sellerName: widget.name,
            sellerUid: widget.uId,
          ),
        ],
      ),
    );
  }
}

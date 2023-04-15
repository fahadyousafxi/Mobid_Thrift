import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/chat_module/widgets/chat/message_bubble.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class ChatRoom extends StatefulWidget {
  // late Map<String, dynamic> userMap;
  String? chatRoomId;
  String? sellerName;
  String? sellerEmail;
  String? sellerUid;
  String? sellerPhoto;
  ChatRoom(
      {required this.chatRoomId,
      required this.sellerEmail,
      required this.sellerUid,
      required this.sellerPhoto,
      required this.sellerName,
      Key? key})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  final TextEditingController _message = TextEditingController();
  void onSendMessage() async {
    var singleMessageUid = DateTime.now().millisecondsSinceEpoch;
    await _firebaseFireStore
        .collection('ChatRoom')
        .doc(widget.chatRoomId.toString())
        .collection('chats')
        .doc(singleMessageUid.toString())
        .set({
      'sendBy': _firebaseAuth.currentUser?.displayName.toString(),
      'sendByEmail': _firebaseAuth.currentUser?.email.toString(),
      'message': _message.text,
      'time': FieldValue.serverTimestamp(),
      'singleMessageUid': singleMessageUid,
    });

    _message.clear();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
    _firebaseFireStore
        .collection('SellerCenterUsers')
        .doc(widget.sellerUid)
        .collection('ChatUsers')
        .doc(widget.chatRoomId)
        .set({
      'buyerName': _firebaseAuth.currentUser?.displayName.toString(),
      'sellerName': widget.sellerName,
      'sellerUid': widget.sellerUid,
      'buyerUid': _firebaseAuth.currentUser?.uid,
      'buyerPhoto': _firebaseAuth.currentUser?.photoURL,
      'sellerPhoto': '${widget.sellerPhoto}',
      'roomUId': widget.chatRoomId,
      'userEmail': _firebaseAuth.currentUser?.email,
      'sellerEmail': widget.sellerEmail
    });
    _firebaseFireStore
        .collection('ChatRoom')
        .doc(widget.chatRoomId.toString())
        .update({
      'buyerName': _firebaseAuth.currentUser?.displayName.toString(),
      'sellerName': widget.sellerName,
      'sellerUid': widget.sellerUid,
      'buyerUid': _firebaseAuth.currentUser?.uid,
      'buyerPhoto': _firebaseAuth.currentUser?.photoURL,
      'userEmail': _firebaseAuth.currentUser?.email,
      'sellerEmail': widget.sellerEmail
      // 'sellerPhoto': '',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context,
          title: widget.sellerName.toString(), showCart: false),
      body: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firebaseFireStore
                  .collection('ChatRoom')
                  .doc(widget.chatRoomId.toString())
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                String displayName =
                    '${_firebaseAuth.currentUser?.displayName.toString()}';
                if (snapshot.data != null) {
                  return ListView.builder(
                    // physics: AlwaysScrollableScrollPhysics(),
                    // controller: _scrollController,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageBubble(
                          message: snapshot.data?.docs[index]['message'],
                          username: displayName,
                          sellerName: widget.sellerName.toString(),
                          isMe: snapshot.data?.docs[index]['sendByEmail']
                                      .toString() ==
                                  _firebaseAuth.currentUser?.email
                              ? true
                              : false);
                      // Text(snapshot.data?.docs[index]['message']);
                    },
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: _message,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.only(top: 4, left: 6),
                        hintText: 'Enter a message'),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                IconButton(
                    onPressed: () {
                      onSendMessage();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

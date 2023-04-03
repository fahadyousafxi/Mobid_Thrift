import 'package:flutter/material.dart';
import 'package:mobidthrift/chat_module/Chating/chat_room.dart';
import 'package:mobidthrift/providers/chats_provider.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  ChatsProvider chatsProvider = ChatsProvider();

  @override
  void initState() {
    ChatsProvider chatsProvider = Provider.of(context, listen: false);
    chatsProvider.getChatsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chatsProvider = Provider.of(context);
    print('*********************');
    print(chatsProvider.getChatsDataList.length);
    print('*********************');
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Chats'),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView.builder(
          itemCount: chatsProvider.getChatsDataList.length,
          itemBuilder: (BuildContext context, int index) {
            var data = chatsProvider.getChatsDataList[index];
            return Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  tileColor: Colors.grey.shade400,
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  splashColor: Colors.blue.shade100,
                  leading: data.sellerPhoto == ''
                      ? Icon(
                          Icons.person_3_rounded,
                          size: 33,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            data.sellerPhoto.toString(),
                          ),
                          radius: 25,
                        ),
                  // Image.network(data.sellerPhoto.toString()),
                  title: Text(data.sellerName.toString()),
                  subtitle: Text(data.sellerEmail.toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatRoom(
                                chatRoomId: data.roomUid,
                                sellerEmail: data.sellerEmail,
                                sellerUid: data.sellerUid,
                                sellerPhoto: data.sellerPhoto,
                                sellerName: data.sellerName)));
                  },
                ),
                Divider(
                  thickness: 5,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

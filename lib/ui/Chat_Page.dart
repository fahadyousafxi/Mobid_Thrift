// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    ChatMessage message = ChatMessage(
      text: _textController.text,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text('Empty Chat'),
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, int index) => _messages[index],
              ),
            ),
            const Divider(height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder( borderRadius: BorderRadius.circular(20), ),
                        contentPadding: const EdgeInsets.only(top: 4, left: 6),
                        hintText: 'Enter a message'
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send))
              ],
            ),
            const SizedBox(height: 8,)
          ],
        ),
      ),
      bottomNavigationBar: Container(height: 22,),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text});


  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(margin: const EdgeInsets.only(right: 16.0))
            ]));
  }
}

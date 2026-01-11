import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telegram/auth_service.dart';
import 'package:telegram/chat_bubble.dart';
import 'package:telegram/chat_service.dart';
import 'package:telegram/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;

  const ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  // funksiyalar uchun
  final _auth = AuthService();
  final _chat = ChatService();

  // text
  final _messageController = TextEditingController();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chat.sendMessage(
          widget.recieverID,
          _messageController.text
      );

      // xabar jo'natilgandan keyin, xabarni tozalaydi
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
            widget.recieverEmail
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // hamma xabarlarni ko'rsatish
          Expanded(
              child: _messagesList()
          ),

          // xabar jo'natish TextField
          userInput()
        ],
      ),
    );
  }


  Widget _messagesList(){
    String senderID = _auth.getCurrentUser()!.uid;

    return StreamBuilder(
        stream: _chat.getMessages(senderID, widget.recieverID),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Xatolik...");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 3️⃣ data yo‘q
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Hozircha xabar yo‘q"));
          }

          // 4️⃣ data bor
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => messageItem(doc))
                .toList(),
          );
        }
    );
  }


  Widget messageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // hozirgi usermi?
    bool isCurrentUser =
        data["senderID"] == _auth.getCurrentUser()!.uid;

    var alignment = isCurrentUser ?
    Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ?
        CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
              message: data["messageText"],
              isCurrentUser: isCurrentUser
          )
        ],
      ),
    );
  }


  Widget userInput(){
    return Row(
      children: [
        // textfield
        Expanded(
            child: MyTextfield(
                hinText: "Xabar jo'nating",
                controller: _messageController,
                isObscure: false,
                prefixIcon: Icon(Icons.abc)
            )
        ),

        // send tugmacha
        IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send_sharp)
        )
      ],
    );
  }
}
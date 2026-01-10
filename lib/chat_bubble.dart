import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {

  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.isCurrentUser ?
          Colors.green : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20
      ),
      child: Text(
        widget.message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.person});

  final String text;
  final String person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Text(person, style: const TextStyle(color: Colors.black)),
        ),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}

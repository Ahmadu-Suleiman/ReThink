import 'package:flutter/material.dart';
import 'package:rethink/gemini_util.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chat = GeminiUtil.gemini.chat([]);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

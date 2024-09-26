import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rethink/gemini_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool loading = false;
  final controller = TextEditingController();
  final scrollController = ScrollController();
  List<Content> contents = [
    Content(parts: [
      Parts(
          text: "Hi there! I'm Thinker, your AI sustainability companion. "
              "I'm here to help you learn more about sustainable practices, "
              "answer your questions, and offer personalized advice on how to "
              "reduce your environmental impact.")
    ], role: 'model')
  ];

  Future<void> sendMessage(String message) async {
    contents.add(Content(parts: [Parts(text: message)], role: 'user'));

    final response = await GeminiUtil.gemini.chat(contents);
    final responseText = response?.output ?? 'No output';
    contents.add(Content(parts: [Parts(text: responseText)], role: 'model'));
  }

  Widget chatBubble(String author, String text) => Card(
      color: author == 'model'
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(author == 'model' ? 'Thinker' : 'You',
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Divider(
                thickness: 0.1,
                indent: 8,
                endIndent: 8,
                color: Theme.of(context).colorScheme.primary),
            IgnorePointer(
                child: Markdown(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    data: text))
          ])));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      children: contents
                          .map((content) => chatBubble(content.role ?? 'model',
                              content.parts?.last.text ?? 'No output'))
                          .toList())))),
      if ((Platform.isAndroid || Platform.isIOS) && contents.length == 1)
        TextButton.icon(
            onPressed: openSMS,
            label: const Text('Offline? Use our SMS service instead'),
            icon: const Icon(Icons.sms)),
      Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
                child: TextField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Type a message',
                        suffixIcon: IconButton(
                            icon: loading
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.send),
                            onPressed: loading
                                ? null
                                : () async {
                                    String text = controller.text;
                                    setState(() {
                                      loading = true;
                                      controller.text = '';
                                    });
                                    await sendMessage(text);
                                    setState(() => loading = false);
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  }),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none))))
          ]))
    ]));
  }

  void openSMS() async {
    final Uri launchUri = Uri.parse('sms:606700');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not open SMS';
    }
  }
}

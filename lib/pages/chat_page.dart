import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rethink/gemini_util.dart';

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
            Markdown(
                padding: const EdgeInsets.all(0), shrinkWrap: true, data: text)
          ])));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                  children: contents
                      .map((content) => chatBubble(content.role ?? 'model',
                          content.parts?.last.text ?? 'No output'))
                      .toList()))),
      Container(
          margin: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
                child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Type a message',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none)))),
            IconButton(
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
                        setState(() {
                          loading = false;
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                      })
          ]))
    ]));
  }
}

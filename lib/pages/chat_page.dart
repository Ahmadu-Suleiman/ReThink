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
  final TextEditingController controller = TextEditingController();
  List<Content> contents = [];

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
          padding: const EdgeInsets.all(4),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(author == 'model' ? 'Thinker' : 'You',
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Markdown(shrinkWrap: true, data: text)
          ])));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      if (contents.isEmpty)
        Center(
            child: Text('Start conversation',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold))),
      Expanded(
          child: SingleChildScrollView(
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
                        setState(() => loading = true);
                        await sendMessage(controller.text);
                        setState(() {
                          controller.text = '';
                          loading = false;
                        });
                      })
          ]))
    ]));
  }
}

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:rethink/config/extensions.dart';
import 'package:rethink/config/gemini.dart';
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
  final chat = Gemini.model.startChat(history: [
    Content.model([
      TextPart("Hi there! I'm Thinker, your AI sustainability companion. "
          "I'm here to help you learn more about sustainable practices, "
          "answer your questions, and offer personalized advice on how to "
          "reduce your environmental impact.")
    ])
  ]);

  // Updated to use List<Content> from firebase_ai
  List<Content> contents = [];

  @override
  void initState() {
    super.initState();
    // Initialize contents with the initial model message
    contents.addAll(chat.history);
  }

  Future<void> sendMessage(String message) async {
    // Add user message to local list
    final userMessage = Content.text(message);
    contents.add(userMessage);

    // Send message to Gemini and add response to local list
    final response = await chat.sendMessage(userMessage);
    final responseText = response.text ?? 'No output from model';
    contents.add(Content.model([TextPart(responseText)]));
  }

  Widget chatBubble(String author, String text) => Card(
      color: author == 'model'
          ? context.colorScheme.primaryContainer
          : context.colorScheme.secondaryContainer,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(author == 'model' ? 'Thinker' : 'You',
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            IgnorePointer(child: MarkdownBlock(data: text))
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
                      // Render messages from the local 'contents' list
                      children: contents.map((content) {
                    // Extract text from the first part, assuming text content
                    final text = content.parts
                            .whereType<TextPart>()
                            .map((part) => part.text)
                            .join(
                                '\n') // Join if multiple text parts, though usually one for chat
                        ??
                        'No text content';
                    return chatBubble(
                        content.role ?? 'model',
                        // Default to model if role is null
                        text);
                  }).toList())))),
      if (contents.length <=
          1) // Show SMS button if only initial message is present
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
                                    if (text.isEmpty)
                                      return; // Don't send empty messages
                                    setState(() {
                                      loading = true;
                                      controller.text = '';
                                    });
                                    await sendMessage(text);
                                    setState(() => loading = false);
                                    // Scroll to bottom after message is sent and UI updated
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (scrollController.hasClients) {
                                        scrollController.animateTo(
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                      }
                                    });
                                  }),
                        filled: true,
                        fillColor: context.colorScheme.secondaryContainer,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none))))
          ]))
    ]));
  }

  void openSMS() async {
    final Uri launchUri =
        Uri.parse('sms:19122'); // Consider making this configurable
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Handle the error, e.g., show a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch SMS app.')),
        );
      }
    }
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rethink/gemini_util.dart';

import '../util.dart';
import 'camera_page.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  PreviewData? previewData;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    final items = [funFact, article, challenge];
    return Scaffold(
        body: ListView(children: items),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CameraPage())),
            child: const Icon(Icons.photo_camera_back)));
  }

  Widget get funFact => Card(
      child: Padding(
          padding: const EdgeInsets.all(14),
          child: FutureBuilder(
              future: GeminiUtil.funFact(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Markdown(
                      shrinkWrap: true, selectable: true, data: snapshot.data!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })));

  Widget get article {
    String article = Util
        .informativeArticles[random.nextInt(Util.informativeArticles.length)];
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: LinkPreview(
                enableAnimation: true,
                onPreviewDataFetched: (data) =>
                    setState(() => previewData = data),
                previewData: previewData,
                text: article,
                width: double.infinity)));
  }

  Widget get challenge {
    DateTime date = DateTime.now().add(const Duration(days: 0));
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: [
              CircleAvatar(child: Text('${date.day}')),
              Text(Util.dailyChallenges[0]),
              Text('${date.month}/${date.day}')
            ])));
  }
}

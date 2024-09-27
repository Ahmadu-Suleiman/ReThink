import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import '../util.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  Map<String, PreviewData> datas = {};

  @override
  void initState() {
    super.initState();
    Util.informativeArticles.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: Util.informativeArticles.length,
            itemBuilder: (context, index) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    key: ValueKey(Util.informativeArticles[index]),
                    margin: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: LinkPreview(
                            enableAnimation: true,
                            onPreviewDataFetched: (data) => setState(() =>
                                datas = {
                                  ...datas,
                                  Util.informativeArticles[index]: data
                                }),
                            previewData: datas[Util.informativeArticles[index]],
                            text: Util.informativeArticles[index],
                            width: double.infinity))))));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:rethink/config/extensions.dart';

import '../util.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  Map<String, LinkPreviewData> data = {};

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
                    margin: context.pagePadding,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: context.colorScheme.surface),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: LinkPreview(
                            enableAnimation: true,
                            onLinkPreviewDataFetched: (data) => setState(() =>
                                this.data = {
                                  ...this.data,
                                  Util.informativeArticles[index]: data
                                }),
                            linkPreviewData:
                                data[Util.informativeArticles[index]],
                            text: Util.informativeArticles[index],
                            maxWidth: double.infinity))))));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:rethink/config/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lists.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  Map<String, LinkPreviewData?> data = {};

  @override
  void initState() {
    super.initState();
    Lists.informativeArticles.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.pagePadding,
          child: ListView.separated(
            itemCount: Lists.informativeArticles.length,
            itemBuilder: (context, index) {
              final articleUrl = Lists.informativeArticles[index];
              return DecoratedBox(
                key: ValueKey(articleUrl),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: context.colorScheme.surface),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: LinkPreview(
                    enableAnimation: true,
                    onTap: (link) => launchUrl(Uri.parse(link)),
                    onLinkPreviewDataFetched: (previewData) => setState(
                        () => data = {...data, articleUrl: previewData}),
                    linkPreviewData: data[articleUrl],
                    text: articleUrl,
                    maxWidth: double.infinity,
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}

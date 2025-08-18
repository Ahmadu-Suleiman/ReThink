import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:rethink/config/extensions.dart';
import 'package:rethink/config/gemini.dart';
import 'package:rethink/config/routes.dart';

import '../lists.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  LinkPreviewData? previewData;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    final items = [funFact, article, challenge];
    return Scaffold(
        body: ListView(padding: const EdgeInsets.all(12), children: items),
        floatingActionButton: FloatingActionButton(
            onPressed: () => context.pushNamed(Routes.cameraPage),
            child: const Icon(Icons.photo_camera_back)));
  }

  Widget get funFact => Card(
      child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            Text('Fun fact', style: context.titleStyle),
            const Divider(),
            FutureBuilder(
                future: Gemini.funFact,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return MarkdownBlock(
                        selectable: true, data: snapshot.data!);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  }else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ])));

  Widget get article {
    final article = Lists
        .informativeArticles[random.nextInt(Lists.informativeArticles.length)];
    return Card(
        child: Padding(
            padding: context.pagePadding,
            child: Column(children: [
              Text('Picked for you', style: context.titleStyle),
              const Divider(),
              LinkPreview(
                  enableAnimation: true,
                  onLinkPreviewDataFetched: (data) =>
                      setState(() => previewData = data),
                  linkPreviewData: previewData,
                  text: article,
                  maxWidth: double.infinity)
            ])));
  }

  Widget get challenge {
    DateTime date = DateTime.now().add(const Duration(days: 0));
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(spacing: 12, children: [
              Text('Challenge for Today!', style: context.titleStyle),
              const Divider(),
              CircleAvatar(
                  radius: 40,
                  child: Text('${date.day}', style: context.bodyStyle)),
              Text(Lists.dailyChallenges[0], textAlign: TextAlign.center),
              Text(DateFormat.yMMMMEEEEd().format(date))
            ])));
  }
}

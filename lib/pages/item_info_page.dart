import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:rethink/config/extensions.dart';

class ItemInfoPage extends StatelessWidget {
  const ItemInfoPage({super.key, required this.info});

  final String? info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: context.pagePadding,
        child: SingleChildScrollView(
          child: MarkdownBlock(
              selectable: true, data: info ?? 'No info available\n🤢'),
        ),
      ),
    ));
  }
}

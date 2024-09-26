import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key, required this.info});

  final String? info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Markdown(
                padding: const EdgeInsets.all(12),
                selectable: true,
                data: info ?? 'No info available\n🤢')));
  }
}

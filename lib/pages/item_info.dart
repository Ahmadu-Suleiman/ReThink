import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rethink/style.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key, required this.info});

  final String info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context, 'Item Info', const Icon(Icons.eco_outlined)),
        body: Markdown(
            padding: const EdgeInsets.all(12), selectable: true, data: info));
  }
}

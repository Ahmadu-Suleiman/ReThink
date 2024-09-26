import 'package:flutter/material.dart';

PreferredSizeWidget appbar(BuildContext context, String title, Widget icon) =>
    AppBar(
        title: Text(title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        leading: icon);

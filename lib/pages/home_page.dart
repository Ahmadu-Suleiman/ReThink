import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rethink/config/extensions.dart';
import 'package:rethink/pages/challenge_page.dart';
import 'package:rethink/pages/chat_page.dart';
import 'package:rethink/pages/learn_page.dart';

import 'overview_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('ReThink',
                style: context.appTitleStyle?.addColor(context.primary)?.bold)),
        body: PersistentTabView(context,
            controller: PersistentTabController(initialIndex: 0),
            backgroundColor: context.colorScheme.surface,
            screens: const [
              OverviewPage(),
              LearnPage(),
              ChallengePage(),
              ChatPage()
            ],
            items: [
              PersistentBottomNavBarItem(
                  activeColorPrimary: context.primary,
                  inactiveColorPrimary: context.colorScheme.secondary,
                  icon: const Icon(Icons.eco),
                  title: 'Overview'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: context.primary,
                  inactiveColorPrimary: context.colorScheme.secondary,
                  icon: const Icon(Icons.school),
                  title: 'Learn'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: context.primary,
                  inactiveColorPrimary: context.colorScheme.secondary,
                  icon: const Icon(Icons.event),
                  title: 'Challenges'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: context.primary,
                  inactiveColorPrimary: context.colorScheme.secondary,
                  icon: const Icon(Icons.chat),
                  title: 'Chat')
            ]));
  }
}

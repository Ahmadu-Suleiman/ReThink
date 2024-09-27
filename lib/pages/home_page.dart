import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rethink/pages/challenge_page.dart';
import 'package:rethink/pages/chat_page.dart';
import 'package:rethink/pages/learn_page.dart';

import 'overview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);
    return Scaffold(
        appBar: AppBar(
            title: Text('ReThink',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold))),
        body: PersistentTabView(context,
            controller: controller,
            backgroundColor: Theme.of(context).colorScheme.surface,
            screens: const [
              Overview(),
              LearnPage(),
              ChallengePage(),
              ChatPage()
            ],
            items: [
              PersistentBottomNavBarItem(
                  activeColorPrimary: Theme.of(context).colorScheme.primary,
                  inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.eco),
                  title: 'Overview'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Theme.of(context).colorScheme.primary,
                  inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.school),
                  title: 'Learn'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Theme.of(context).colorScheme.primary,
                  inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.event),
                  title: 'Challenge'),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Theme.of(context).colorScheme.primary,
                  inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.chat),
                  title: 'Chat')
            ]));
  }
}

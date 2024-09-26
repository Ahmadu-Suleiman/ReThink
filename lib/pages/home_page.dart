import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rethink/pages/camera_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('ReThink',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold))),
        body: PersistentTabView(context,
            controller: controller,
            backgroundColor: Theme.of(context).colorScheme.surface,
            screens: [
              Container(),
              Container(),
              Container(),
              Container()
            ],
            items: [
              PersistentBottomNavBarItem(
                  activeColorPrimary: Theme.of(context).colorScheme.primary,
                  inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.eco),
                  title: 'Home'),
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
            ]),
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CameraPage())),
            child: const Icon(Icons.photo_camera_back)),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat);
  }
}

import 'package:go_router/go_router.dart';
import 'package:rethink/pages/item_info_page.dart';
import 'package:rethink/pages/learn_page.dart';

import '../pages/camera_page.dart';
import '../pages/challenge_page.dart';
import '../pages/chat_page.dart';
import '../pages/home_page.dart';

class Routes {
  const Routes._();

  static const homePage = 'home';
  static const cameraPage = 'camera';
  static const challengePage = 'challenge';
  static const chatPage = 'chat';
  static const learnPage = 'learn';
  static const itemInfoPage = 'item-info';

  static const id = 'id';

  static final router = GoRouter(
    initialLocation: '/$homePage',
    routes: [
      GoRoute(
          path: '/$homePage',
          name: homePage,
          builder: (context, state) => HomePage(),
          routes: [
            GoRoute(
              path: cameraPage,
              name: cameraPage,
              builder: (context, state) => CameraPage(),
            ),
            GoRoute(
              path: challengePage,
              name: challengePage,
              builder: (context, state) => ChallengePage(),
            ),
            GoRoute(
              path: chatPage,
              name: chatPage,
              builder: (context, state) => ChatPage(),
            ),
            GoRoute(
              path: learnPage,
              name: learnPage,
              builder: (context, state) => LearnPage(),
            ),
            GoRoute(
                path: itemInfoPage,
                name: itemInfoPage,
                builder: (context, state) {
                  final info = state.extra as String?;
                  return ItemInfoPage(info: info);
                }),
          ]),
    ],
  );
}

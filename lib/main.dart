import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/firebase_options.dart';
import 'config/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.latoTextTheme();
    return MaterialApp.router(
        title: 'ReThink',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: textTheme,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        routerConfig: Routes.router);
  }
}

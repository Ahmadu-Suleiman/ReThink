import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:rethink/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Gemini.init(apiKey: dotenv.env['GEMINI_KEY'] ?? '');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ReThink',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        home: const HomePage());
  }
}

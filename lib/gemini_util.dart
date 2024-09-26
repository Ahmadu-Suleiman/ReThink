import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:logger/logger.dart';

class GeminiUtil {
  static final gemini = Gemini.instance;
  static final logger = Logger();

  static Future<String?> info(Uint8List image) async {
    String? info;
    try {
      final candidates = await gemini
          .textAndImage(text: "What is this picture?", images: [image]);
      info = candidates?.content?.parts?.last.text;
    } catch (e) {
      logger.e(e.toString());
    }
    return info;
  }
}

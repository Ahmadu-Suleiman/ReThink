import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:logger/logger.dart';

class GeminiUtil {
  static final gemini = Gemini.instance;
  static final logger = Logger();

  static Future<String?> info(Uint8List image) async {
    String? info;
    try {
      final candidates = await gemini.textAndImage(
          text: 'Provide detailed information about the environmental impact '
              'of item(s) in the image. Include information on its carbon '
              'footprint, recycling methods, disposal options, and any '
              'alternative actions or products that are more sustainable',
          images: [image]);
      info = candidates?.content?.parts?.last.text;
    } catch (e) {
      logger.e(e.toString());
    }
    return info;
  }

  static Future<String?> funFact() async {
    String? fact;
    try {
      final candidates = await gemini
          .text('Generate a daily fun fact related to sustainability or '
              'environmental protection that is relevant to an African '
              'audience. The fact should be interesting, informative, and '
              'easily digestible, with a cultural or historical context when '
              'possible.');
      fact = candidates?.content?.parts?.last.text;
    } catch (e) {
      logger.e(e.toString());
    }
    return fact;
  }
}

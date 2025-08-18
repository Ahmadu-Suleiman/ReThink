import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

class Gemini {

  const Gemini._();

  static final _model =
  FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

  static final _imagePrompt = 'Provide detailed information about the environmental impact '
      'of item(s) in the image. Include information on its carbon '
      'footprint, recycling methods, disposal options, and any '
      'alternative actions or products that are more sustainable';
  static final _funFactPrompt =
      'Generate a daily fun fact related to sustainability or '
      'environmental protection that is relevant to an African '
      'audience. The fact should be interesting, informative, and '
      'easily digestible, with a cultural or historical context when '
      'possible. Do not add a title.';

  static Future<String?> info(Uint8List image) async {
    final prompt = TextPart(_imagePrompt);
    final imagePart = InlineDataPart('image/jpeg', image);

    final response = await _model.generateContent([
      Content.multi([prompt, imagePart])
    ]);
    return response.text;
  }

  static Future<String?> get funFact async {
    final prompt = [Content.text(_funFactPrompt)];
    final response = await _model.generateContent(prompt);
    return response.text;
  }

import 'dart:convert';

import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle? get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle? get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle? get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle? get bolder => copyWith(fontWeight: FontWeight.w900);

  TextStyle? get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle? get italicize => copyWith(fontStyle: FontStyle.italic);

  TextStyle? addColor(Color color) => copyWith(color: color);
}

extension BuildContextExtensions on BuildContext {
  EdgeInsetsGeometry get pagePadding => const EdgeInsets.all(12);

  BorderRadiusGeometry get pageRadius => BorderRadius.circular(10);

  Radius get borderRadius => Radius.circular(10);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primary => colorScheme.primary;

  Brightness get brightness => MediaQuery.platformBrightnessOf(this);

  TextStyle? get appTitleStyle => textTheme.headlineSmall;

  TextStyle? get wordStyle => textTheme.headlineMedium?.bold;

  TextStyle? get labelStyle => textTheme.labelLarge?.semiBold;

  TextStyle? get noteLabelStyle => textTheme.labelMedium;

  TextStyle? get bodyStyle => textTheme.bodyMedium;

  TextStyle? get titleStyle => textTheme.titleLarge;

  TextStyle? get actionStyle => textTheme.bodyLarge;
}

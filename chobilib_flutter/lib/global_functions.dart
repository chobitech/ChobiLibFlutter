
import 'dart:ui';

import 'package:flutter/material.dart';

void benchmark(Function() f) {
  final st = DateTime.now().microsecondsSinceEpoch;
  f();
  final et = DateTime.now().microsecondsSinceEpoch;
  debugPrint('[BENCHMARK] time = ${et - st} ms');
}




const fontVariation100 = [ FontVariation('wght', 100.0) ];
const fontVariation200 = [ FontVariation('wght', 200.0) ];
const fontVariation300 = [ FontVariation('wght', 300.0) ];
const fontVariation400 = [ FontVariation('wght', 400.0) ];
const fontVariation500 = [ FontVariation('wght', 500.0) ];
const fontVariation600 = [ FontVariation('wght', 600.0) ];
const fontVariation700 = [ FontVariation('wght', 700.0) ];


TextTheme generateAndApplyToAllWithStyles({
    required TextStyle mediumTextStyle,
    required TextStyle largeTextStyle,
    required TextStyle smallTextStyle,
}) {

  return TextTheme(
    bodyMedium: mediumTextStyle,
    bodyLarge: largeTextStyle,
    bodySmall: smallTextStyle,

    displayMedium: mediumTextStyle,
    displayLarge: largeTextStyle,
    displaySmall: smallTextStyle,

    labelMedium: mediumTextStyle,
    labelLarge: largeTextStyle,
    labelSmall: smallTextStyle,

    titleMedium: mediumTextStyle,
    titleLarge: largeTextStyle,
    titleSmall: smallTextStyle,

    headlineMedium: mediumTextStyle,
    headlineLarge: largeTextStyle,
    headlineSmall: smallTextStyle,
  );

}

TextTheme generateAndApplyToAllWithValues({
  String? fontFamily,
  double? mediumFontSize,
  double? largeFontSize,
  double? smallFontSize,
  Color? bodyColor,
  Color? displayColor,
}) {

  final mediumStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.w400,
    fontVariations: fontVariation400,
  );

  final largeStyle = mediumStyle.copyWith(
    fontSize: largeFontSize,
    fontWeight: FontWeight.w700,
    fontVariations: fontVariation700,
  );

  final smallStyle = mediumStyle.copyWith(
    fontSize: smallFontSize,
  );

  return generateAndApplyToAllWithStyles(
    mediumTextStyle: mediumStyle,
    largeTextStyle: largeStyle,
    smallTextStyle: smallStyle,
  ).apply(
    bodyColor: bodyColor,
    displayColor: displayColor ?? bodyColor,
  );

}


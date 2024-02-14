
import 'dart:math';
import 'dart:ui';

import 'package:chobilib_flutter/extensions.dart';

final colorHexRegex = RegExp(r'#([\da-f]{8}|[\da-f]{6}|[\da-f]{3})', caseSensitive: false);

extension StringExtensionForColor on String {

  int hexToInt() => int.parse(this, radix: 16);

  Color? hexToColor() {
    return colorHexRegex.firstMatch(this)?.group(1)?.let((hex) {
      switch (hex.length) {
        case 8:
          return Color.fromARGB(
            '${hex[0]}${hex[1]}'.hexToInt(),
            '${hex[2]}${hex[3]}'.hexToInt(),
            '${hex[4]}${hex[5]}'.hexToInt(),
            '${hex[6]}${hex[7]}'.hexToInt(),
          );
        case 3:
          return Color.fromARGB(
            255,
            '${hex[0]}${hex[0]}'.hexToInt(),
            '${hex[1]}${hex[1]}'.hexToInt(),
            '${hex[2]}${hex[2]}'.hexToInt(),
          );
        default:
          return Color.fromARGB(
            255,
            '${hex[0]}${hex[1]}'.hexToInt(),
            '${hex[2]}${hex[3]}'.hexToInt(),
            '${hex[4]}${hex[5]}'.hexToInt(),
          );
      }
    });
  }

}


extension IntExtensionForColor on int {
  int clamp255() => min(255, max(0, this));

  double toColorDouble() {
    return (this / 255.0).clamp01();
  }

  String toColorHex() => toRadixString(16).padLeft(2, '0');
}

extension DoubleExtensionForColor on double {
  double clamp01() => clampDouble(this, 0.0, 255.0);

  int toColorInt() {
    return (clamp01() * 255.0).toInt();
  }

  String toColorHex() => toColorInt().toColorHex();
}

extension ColorExtensions on Color {

  Color add({int r = 0, int g = 0, int b = 0, int a = 0,}) {
    return Color.fromARGB(
      (alpha + a).clamp255(),
      (red + r).clamp255(),
      (green + g).clamp255(),
      (blue + b).clamp255(),
    );
  }

  Color addColor(Color color) {
    return add(
      r: color.red,
      g: color.green,
      b: color.blue,
      a: color.alpha,
    );
  }

  String toHexString({bool addAlpha = false}) {
    final sb = StringBuffer();

    if (addAlpha) {
      sb.write(alpha.toColorHex());
    }

    sb.write(red.toColorHex());
    sb.write(green.toColorHex());
    sb.write(blue.toColorHex());

    return '#$sb';
  }
}


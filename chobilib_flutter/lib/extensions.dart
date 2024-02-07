
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

extension AllTypeExtensions on dynamic {
  FutureOr<dynamic> also(FutureOr<void> Function(dynamic v) f) async {
    await f(this);
    return this;
  }

  FutureOr<dynamic> let(FutureOr<dynamic> Function(dynamic v) f) async {
    return await f(this);
  }
}


extension RectExtension on Rect {
  bool isValidRect() {
    return !left.isNaN && !top.isNaN && !right.isNaN && !bottom.isNaN;
  }

  bool isContainsPoint(double x, double y) {
    return contains(Offset(x, y));
  }
}

extension SizeExtension on Size {
  Rect getRect({double left = 0, double top = 0}) {
    return Rect.fromLTWH(left, top, width, height);
  }

  Rect getRectWithCenter({required double centerX, required double centerY}) {
    return Rect.fromCenter(center: Offset(centerX, centerY), width: width, height: height);
  }
}

extension CanvasExtension on Canvas {

  void drawText(
      String text,
      Offset position,
      {
        TextStyle? style,
        Alignment alignment = Alignment.centerLeft,
        TextAlign textAlign = TextAlign.left,
        int maxLines = 1,
      }
      ) {

    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      maxLines: maxLines,
    );

    textPainter.layout();

    final double x, y;

    if (alignment.x < 0) {
      x = position.dx;
    } else if (alignment.x > 0) {
      x = position.dx - textPainter.width;
    } else {
      x = position.dx - textPainter.width * 0.5;
    }

    if (alignment.y < 0) {
      y = position.dy - textPainter.height;
    } else if (alignment.y > 0) {
      y = position.dy + textPainter.height;
    } else {
      y = position.dy - textPainter.height * 0.5;
    }

    textPainter.paint(this, Offset(x, y));
  }

}

extension StringDynamicMapExtension on Map<String, dynamic> {

  T get<T>(String key, T defVal) {
    return this[key] ?? defVal;
  }

  DateTime? getDateTime(String key, {DateTime? defaultDateTime}) {
    return this[key]?.let((t) => DateTime.fromMillisecondsSinceEpoch(t)) ?? defaultDateTime;
  }

  DateTime getDateTimeOrNow(String key) {
    return getDateTime(key, defaultDateTime: DateTime.now())!;
  }


  bool getBool(String key, bool defVal) {
    return get(key, defVal.toInt()) > 0;
  }
}


extension AnyListExtension<T> on List<T> {

  int get lastIndex => (length > 0) ? length - 1 : -1;

  void replace(int index, T newValue) {
    if (index < 0 || index > lastIndex) {
      return;
    }

    this[index] = newValue;
  }
}


extension BoolExtension on bool {

  int toInt() => this ? 1 : 0;

  void when({void Function()? inTrue, void Function()? inFalse,}) {
    if (this) {
      inTrue?.call();
    } else {
      inFalse?.call();
    }
  }

}

extension TextEditControllerExtension on TextEditingController {

  int get currentCursorPosition => selection.end;

  void setCursorPosition({int position = 0}) {
    selection = TextSelection.fromPosition(TextPosition(offset: position.clamp(0, text.length)));
  }

  void moveCursorWithDelta(int delta) {
    setCursorPosition(position: currentCursorPosition + delta);
  }

  void setText(String text, {bool movePositionToEnd = true}) {
    final curPos = (selection.end).clamp(0, this.text.length);
    final pos = movePositionToEnd ? (curPos + text.length) : curPos;
    this.text = text;
    setCursorPosition(position: pos);
  }

  void insertText(String text, {int? positionAt}) {
    final insertPos = (positionAt ?? selection.end).clamp(0, this.text.length);

    final curChars = this.text.characters.toList();

    if (insertPos == this.text.length) {
      curChars.add(text);
    } else {
      curChars.insert(insertPos, text);
    }

    this.text = curChars.join('');
    setCursorPosition(position: insertPos + text.length);
  }
}


extension FontWeightExtensions on FontWeight {

  List<FontVariation> toFontVariations() {
    return [
      FontVariation.weight(value.toDouble()),
    ];
  }

}

extension TextStyleExtensions on TextStyle {

  TextStyle applyVariableWeight() {
    return copyWith(
      fontVariations: fontWeight?.toFontVariations(),
    );
  }

}



extension TextThemeExtensions on TextTheme {

  TextTheme applyFontWeightToFontVariationsWith({
    String? fontFamily,
    Color? color,
  }) {
    return copyWith(
      displayLarge: displayLarge?.applyVariableWeight(),
      displayMedium: displayMedium?.applyVariableWeight(),
      displaySmall: displaySmall?.applyVariableWeight(),

      headlineLarge: headlineLarge?.applyVariableWeight(),
      headlineMedium: headlineMedium?.applyVariableWeight(),
      headlineSmall: headlineSmall?.applyVariableWeight(),

      titleLarge: titleLarge?.applyVariableWeight(),
      titleMedium: titleMedium?.applyVariableWeight(),
      titleSmall: titleSmall?.applyVariableWeight(),

      labelLarge: labelLarge?.applyVariableWeight(),
      labelMedium: labelMedium?.applyVariableWeight(),
      labelSmall: labelSmall?.applyVariableWeight(),

      bodyLarge: bodyLarge?.applyVariableWeight(),
      bodyMedium: bodyMedium?.applyVariableWeight(),
      bodySmall: bodySmall?.applyVariableWeight(),
    ).apply(
      fontFamily: fontFamily,
      displayColor: color,
      bodyColor: color,
    );
  }
}

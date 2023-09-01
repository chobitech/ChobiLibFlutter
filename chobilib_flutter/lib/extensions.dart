
import 'dart:ui';

import 'package:flutter/cupertino.dart';

extension AllTypeExtensions<T> on T {

  T also(Function(T t) f) {
    f(this);
    return this;
  }

  Future<T> alsoAsync(Future<void> Function(T t) f) async {
    await f(this);
    return this;
  }

  R let<R>(R Function(T t) f) {
    return f(this);
  }

  Future<R> letAsync<R>(Future<R> Function(T t) f) async {
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


import 'dart:math';

import 'package:chobilib_flutter/randomize.dart';
import 'package:flutter/cupertino.dart';

class RandomString extends Randomize<String> {

  static const String _digits = '0123456789';
  static const String _hexChars = 'abcdef';
  static const String _nonHexChars = 'ghijklmnopqrstuvwxyz';

  RandomString({required List<String> strings, super.random}) : super(elements: strings);

  RandomString.fromString({required String str, Random? random}) : this(strings: str.characters.toList(), random: random);

  RandomString.digitsOnly({Random? random}) : this.fromString(str: _digits, random: random);
  RandomString.lowerHex({Random? random}) : this.fromString(str: _digits + _hexChars, random: random);
  RandomString.upperHex({Random? random}) : this.fromString(str: _digits + _hexChars.toUpperCase(), random: random);
  RandomString.hex({Random? random}) : this.fromString(str: _digits + _hexChars + _hexChars.toUpperCase(), random: random);
  RandomString.lowerChars({Random? random}) : this.fromString(str: _hexChars + _nonHexChars, random: random);
  RandomString.upperChars({Random? random}) : this.fromString(str: (_hexChars + _nonHexChars).toUpperCase(), random: random);
  RandomString.lowerDigitAndChars({Random? random}) : this.fromString(str: _digits + _hexChars + _nonHexChars, random: random);
  RandomString.upperDigitAndChars({Random? random}) : this.fromString(str: _digits + (_hexChars + _nonHexChars).toUpperCase(), random: random);
  RandomString.digitAndChars({Random? random}) : this.fromString(str: _digits + _hexChars + _nonHexChars + (_hexChars + _nonHexChars).toUpperCase(), random: random);

  String getRandomString(int length, {bool allowDuplicate = true}) {
    return getRandomArray(length, allowDuplicate: allowDuplicate).join('');
  }
}

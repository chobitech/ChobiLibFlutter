
import 'package:flutter/cupertino.dart';
import 'dart:math';

class Randomize<T> {

  late final List<T> _elements;
  late final Random _random;

  Randomize({required List<T> elements, Random? random}) {
    if (elements.isEmpty) {
      throw Exception('elements is empty');
    }

    _elements = List.from(elements);
    _random = random ?? Random();
  }

  int get elementCount => _elements.length;

  void addElement(T element) {
    _elements.add(element);
  }

  void removeElement(T element) {
    _elements.remove(element);
  }
  void removeElementAt(int index) {
    _elements.removeAt(index);
  }

  @protected
  int get randomIndex => _random.nextInt(elementCount);

  T next() {
    return _elements[randomIndex];
  }

  List<T> getRandomArray(int length, {bool allowDuplicate = true}) {
    final res = <T>[];

    if (allowDuplicate) {
      for (var i = 0; i < length; i++) {
        res.add(next());
      }
    } else {
      final mLength = min(length, elementCount);
      final tmpArr = List.from(_elements);
      for (var i = 0; i < mLength; i++) {
        final n = _random.nextInt(tmpArr.length);
        res.add(tmpArr.removeAt(n));
      }
    }

    return res;
  }

}

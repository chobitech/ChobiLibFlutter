
import 'package:chobilib_flutter/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListStateNotifier<T> extends StateNotifier<List<T>> {

  ListStateNotifier(List<T> initialList) : super(initialList);

  List<T> get currentList => [...state];

  void _updateListState(List<T> Function(List<T> curList) updater) {
    state = updater(currentList);
  }

  void add(T obj) => _updateListState((curList) => curList..add(obj));
  void addAll(List<T> objList) => _updateListState((curList) => curList..addAll(objList));

  void removeAt(int index) => _updateListState((curList) => curList..removeAt(index));
  void remove(T obj) => _updateListState((curList) => curList..remove(obj));
  void removeLast() => _updateListState((curList) => curList..removeLast());
  void removeRange(int startIndex, int endIndexExclusive) => _updateListState((curList) => curList..removeRange(startIndex, endIndexExclusive));

  void insert(int index, T obj) => _updateListState((curList) => curList..insert(index, obj));
  void insertAll(int index, List<T> objList) => _updateListState((curList) => curList..insertAll(index, objList));

  void replace(int index, T obj) => _updateListState((curList) => curList..replace(index, obj));
  void replaceRange(int start, int end, List<T> objList) => _updateListState((curList) => curList..replaceRange(start, end, objList));

  void clear() => _updateListState((_) => []);

}

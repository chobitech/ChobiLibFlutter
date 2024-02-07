class Pair<T, S> {

  final T first;
  final S second;

  Pair(this.first, this.second);

  @override
  bool operator ==(Object other) {
    if (other is Pair<T, S>) {
      return other.first == first && other.second == second;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;

}

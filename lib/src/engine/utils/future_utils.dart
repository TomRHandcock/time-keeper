extension FutureUtils<T> on Future<T> {
  Future<T?> successOrNull() => catchError((_) => null);
}
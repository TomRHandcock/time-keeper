abstract class SimpleCache<T> {
  Future<T?> fetchValue();

  Future<void> setValue(T? value);

  Future<void> clearValue();
}

class SimpleMemoryCache<T> implements SimpleCache<T> {
  T? _value;

  @override
  Future<void> clearValue() => setValue(null);

  @override
  Future<T?> fetchValue() async => _value;

  @override
  Future<void> setValue(T? value) async {
    _value = value;
  }
}
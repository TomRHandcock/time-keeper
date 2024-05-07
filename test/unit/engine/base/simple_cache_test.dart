import 'package:flutter_test/flutter_test.dart';
import 'package:time_keeper/src/engine/base/simple_cache.dart';

void main() async {
  group("Simple memory cache", () {

    late SimpleMemoryCache<int> sut;

    setUp(() {
      sut = SimpleMemoryCache();
    });

    test("clearValue - sets backing value to null", () async {
      // Setup
      await sut.setValue(42);

      // Run test
      await sut.clearValue();

      // Verify
      final actual = await sut.fetchValue();
      expect(actual, null);
    });

    test("setValue - sets backing value", () async {
      // Run test
      await sut.setValue(4);

      // Verify
      final actual = await sut.fetchValue();
      expect(actual, 4);
    });
  });
}
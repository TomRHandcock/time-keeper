import 'package:flutter_test/flutter_test.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

void main() {
  group("Transform utils unit tests", () {
    test("let - transforms input", () {
      // Setup
      const input = 1;

      // Run test
      final result = input.let((it) => it + 1);

      // Verify
      expect(result, 2);
    });
  });
}
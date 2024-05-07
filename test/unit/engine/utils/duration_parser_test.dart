import 'package:flutter_test/flutter_test.dart';
import 'package:time_keeper/src/engine/utils/duration_parser.dart';

void main() {
  group(
    "Duration parser unit tests",
    () {
      void testParsing(String input, Duration expected) => test(
            "parse - with $input - returns expected result",
            () => expect(DurationParser.parse(input), expected),
          );

      void testSerialization(Duration input, String expected) => test(
            "serialize - with $input - returns expected result",
            () => expect(DurationParser.serialise(input), expected),
          );

      testParsing("00:00:00.0000", Duration.zero);

      testParsing(
        "01:23:45.678901",
        const Duration(
          hours: 1,
          minutes: 23,
          seconds: 45,
          milliseconds: 678,
          microseconds: 901,
        ),
      );

      testParsing(
        "999:999:999.999999",
        const Duration(
          hours: 999,
          minutes: 999,
          seconds: 999,
          milliseconds: 999,
          microseconds: 999,
        ),
      );

      testParsing("0:12:34", const Duration(hours: 0, minutes: 12, seconds: 34));

      testParsing("1", const Duration(hours: 1));

      testSerialization(const Duration(days: 5), "120:00:00.000000");

      testSerialization(const Duration(), "0:00:00.000000");

      testSerialization(
        const Duration(
          days: 1,
          hours: 23,
          minutes: 45,
          seconds: 67,
          milliseconds: 890,
          microseconds: 123,
        ),
        "47:46:07.890123",
      );
    },
  );
}

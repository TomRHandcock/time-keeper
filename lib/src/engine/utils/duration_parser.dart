import 'package:time_keeper/src/engine/utils/transform_utils.dart';

abstract class DurationParser {
  static Duration parse(String input) {
    final components = input.split(RegExp(r"[:.,]"));
    final hours = _parseUnit(components.elementAtOrNull(0));
    final minutes = _parseUnit(components.elementAtOrNull(1));
    final seconds = _parseUnit(components.elementAtOrNull(2));
    final microseconds = _parseUnit(components.elementAtOrNull(3));
    return Duration(hours: hours, minutes: minutes, seconds: seconds, microseconds: microseconds);
  }

  static int _parseUnit(String? input) => input?.let((it) => int.tryParse(it)) ?? 0;

  static String serialise(Duration duration) => duration.toString();
}
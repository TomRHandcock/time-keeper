import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:time_keeper/src/engine/utils/duration_parser.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class TrackingPreference with _$TrackingPreference {
  const TrackingPreference._();

  const factory TrackingPreference({
    required Duration duration,
  }) = _TrackingPreference;

  factory TrackingPreference.fromRecord(TrackingPreferenceRecord record) =>
      TrackingPreference(
        duration: DurationParser.parse(record.duration),
      );

  TrackingPreferenceRecord toRecord() =>
      TrackingPreferenceRecord(DurationParser.serialise(duration));
}

@Collection()
class TrackingPreferenceRecord {

  static const staticId = 0;
  Id id = TrackingPreferenceRecord.staticId;

  String duration;

  TrackingPreferenceRecord(this.duration);
}

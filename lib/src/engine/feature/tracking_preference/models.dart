import 'package:objectbox/objectbox.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_keeper/src/engine/utils/duration_parser.dart';

part 'models.freezed.dart';

@Entity()
class TrackingPreferenceRecord {
  @Id()
  int id = 0;

  String duration;

  TrackingPreferenceRecord(this.id, this.duration);
}

@freezed
class TrackingPreference with _$TrackingPreference {
  const TrackingPreference._();

  const factory TrackingPreference({
    required Duration duration,
  }) = _TrackingPreference;

  TrackingPreferenceRecord toRecord() => TrackingPreferenceRecord(
        0,
        DurationParser.serialise(duration),
      );

  factory TrackingPreference.fromRecord(TrackingPreferenceRecord record) =>
      TrackingPreference(
        duration: DurationParser.parse(record.duration),
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class TrackingSession with _$TrackingSession {
  const TrackingSession._();

  const factory TrackingSession({
    required List<TrackingPoint> points,
  }) = _TrackingSession;

  factory TrackingSession.fromRecord(TrackingSessionRecord record) =>
      TrackingSession(
        points: record.points
            .map((point) => TrackingPoint.fromRecord(point))
            .whereType<TrackingPoint>()
            .toList(),
      );

  TrackingSessionRecord toRecord() => TrackingSessionRecord(
        points.map((point) => point.toRecord()).toList(),
      );
}

@freezed
class TrackingPoint with _$TrackingPoint {
  const TrackingPoint._();

  const factory TrackingPoint({
    required bool isStart,
    required DateTime dateTime,
  }) = _TrackingPoint;

  static TrackingPoint? fromRecord(TrackingPointRecord record) {
    final isStart = record.isStart;
    final dateTime = record.dateTime;
    if (isStart == null || dateTime == null) {
      return null;
    }
    return TrackingPoint(isStart: isStart, dateTime: dateTime);
  }

  TrackingPointRecord toRecord() => TrackingPointRecord(isStart, dateTime);
}

@collection
class TrackingSessionRecord {
  Id id = Isar.autoIncrement;
  List<TrackingPointRecord> points;

  TrackingSessionRecord(this.points);
}

@embedded
class TrackingPointRecord {
  bool? isStart;
  DateTime? dateTime;

  TrackingPointRecord([this.isStart, this.dateTime]);
}

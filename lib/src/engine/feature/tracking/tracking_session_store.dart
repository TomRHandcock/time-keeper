import 'dart:math';

import 'package:isar/isar.dart';
import 'package:time_keeper/src/engine/feature/tracking/models.dart';

abstract class TrackingSessionService {
  Future<List<TrackingSession>> getSessions();

  Future<void> addSession(TrackingSession session);

  Future<void> clearSessions();
}

class TrackingSessionServiceImpl implements TrackingSessionService {
  static const pageSize = 20;

  final Isar isar;

  IsarCollection<TrackingSessionRecord> get collection =>
      isar.trackingSessionRecords;

  const TrackingSessionServiceImpl(this.isar);

  @override
  Future<void> addSession(TrackingSession session) =>
      collection.put(session.toRecord());

  @override
  Future<void> clearSessions() => collection.clear();

  @override
  Future<List<TrackingSession>> getSessions(
      [int offset = 0,
      int pageSize = TrackingSessionServiceImpl.pageSize]) async {
    final collectionSize = await collection.count();
    final initialOffset = collectionSize - (offset + pageSize);
    final clampedInitialOffset = max(0, initialOffset);
    return collection
        .getAll(
            List.generate(pageSize, (index) => clampedInitialOffset + index))
        .then(
          (result) => result
              .whereType<TrackingSessionRecord>()
              .map((record) => TrackingSession.fromRecord(record))
              .toList(),
        );
  }
}

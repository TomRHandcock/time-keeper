import 'dart:math';

import 'package:isar/isar.dart';
import 'package:time_keeper/src/engine/feature/tracking/models.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

abstract class TrackingSessionService {
  Future<TrackingSession?> getSession(int id);

  Future<TrackingSession?> getLastSession();

  Future<List<TrackingSession>> getSessions();

  Future<int> putSession(TrackingSession session);

  Future<int> createSession();

  Future<void> clearSessions();
}

class TrackingSessionServiceImpl implements TrackingSessionService {
  static const pageSize = 20;

  final Isar isar;

  IsarCollection<TrackingSessionRecord> get collection =>
      isar.trackingSessionRecords;

  const TrackingSessionServiceImpl(this.isar);

  @override
  Future<int> putSession(TrackingSession session) =>
      collection.put(session.toRecord());

  @override
  Future<int> createSession() => collection.put(TrackingSessionRecord([]));

  @override
  Future<void> clearSessions() => collection.clear();

  @override
  Future<TrackingSession?> getSession(int id) => collection.get(id).then(
        (result) => result?.let(
          (record) => TrackingSession.fromRecord(record),
        ),
      );

  @override
  Future<TrackingSession?> getLastSession() async {
    final sessionsCount = await collection.count();
    return getSession(sessionsCount - 1);
  }

  @override
  Future<List<TrackingSession>> getSessions([
    int offset = 0,
    int pageSize = TrackingSessionServiceImpl.pageSize,
  ]) async {
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

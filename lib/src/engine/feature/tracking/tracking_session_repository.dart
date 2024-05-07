import 'package:time_keeper/src/engine/feature/tracking/tracking_session_store.dart';

import 'models.dart';

abstract class TrackingSessionRepository {
  Future<void> putSession(TrackingSession session);

  Future<TrackingSession?> getLatestSession();

  Future<TrackingSession> newSession();
}

class TrackingSessionRepositoryImpl implements TrackingSessionRepository {
  final TrackingSessionService _service;

  TrackingSessionRepositoryImpl(this._service);

  @override
  Future<void> putSession(TrackingSession session) =>
      _service.putSession(session);

  @override
  Future<TrackingSession?> getLatestSession() => _service.getLastSession();

  @override
  Future<TrackingSession> newSession() async {
    final id = await _service.createSession();
    final session = await _service.getSession(id);
    if (session == null) {
      throw StateError("Error obtaining session");
    }
    return session;
  }
}

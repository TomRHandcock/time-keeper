import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_store.dart';

abstract class TrackingPreferenceRepository {
  Future<TrackingPreference?> fetchPreference();

  Future<void> setPreference(TrackingPreference preference);
}

class TrackingPreferenceRepositoryImpl implements TrackingPreferenceRepository {
  final TrackingPreferenceService _preferenceService;

  const TrackingPreferenceRepositoryImpl(this._preferenceService);

  @override
  Future<TrackingPreference?> fetchPreference() =>
      _preferenceService.getPreference();

  @override
  Future<void> setPreference(TrackingPreference preference) =>
      _preferenceService.setPreference(preference);
}

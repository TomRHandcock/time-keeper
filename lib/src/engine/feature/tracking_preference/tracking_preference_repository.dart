import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_cache.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_store.dart';

abstract class TrackingPreferenceRepository {
  Future<TrackingPreference?> fetchPreference();

  Future<void> setPreference(TrackingPreference preference);
}

class TrackingPreferenceRepositoryImpl implements TrackingPreferenceRepository {
  final TrackingPreferenceService _preferenceService;
  final TrackingPreferenceCache _preferenceCache;

  const TrackingPreferenceRepositoryImpl(this._preferenceCache, this._preferenceService,);

  @override
  Future<TrackingPreference?> fetchPreference() async {
    final cached = await _preferenceCache.fetchValue();
    if(cached != null) {
      return cached;
    }
    return _preferenceService.getPreference();
  }

  @override
  Future<void> setPreference(TrackingPreference preference) async {
    _preferenceCache.setValue(preference).ignore();
    await _preferenceService.setPreference(preference);
  }
}

import 'package:objectbox/objectbox.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

abstract class TrackingPreferenceService {
  Future<TrackingPreference?> getPreference();

  Future<void> setPreference(TrackingPreference preference);

  Future<void> clearPreference();
}

class TrackingPreferenceServiceImpl implements TrackingPreferenceService {
  late final Store _store;

  Box<TrackingPreferenceRecord> get _box => _store.box();

  TrackingPreferenceServiceImpl(this._store);

  @override
  Future<void> clearPreference() => _box.removeAllAsync();

  @override
  Future<TrackingPreference?> getPreference() => _box.getAsync(0).then(
        (result) => result?.let(
          (it) => TrackingPreference.fromRecord(it),
        ),
      );

  @override
  Future<void> setPreference(TrackingPreference preference) => _box.putAsync(
    preference.toRecord(),
  );
}

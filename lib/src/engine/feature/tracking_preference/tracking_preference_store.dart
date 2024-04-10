import 'package:isar/isar.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

abstract class TrackingPreferenceService {
  Future<TrackingPreference?> getPreference();

  Future<void> setPreference(TrackingPreference preference);

  Future<void> clearPreference();
}

class TrackingPreferenceServiceImpl implements TrackingPreferenceService {
  final Isar isar;

  IsarCollection<TrackingPreferenceRecord> get collection => isar.collection();

  TrackingPreferenceServiceImpl(this.isar);

  @override
  Future<void> clearPreference() => collection.clear();

  @override
  Future<TrackingPreference?> getPreference() =>
      collection.get(TrackingPreferenceRecord.staticId).then(
            (result) => result?.let(
              (record) => TrackingPreference.fromRecord(record),
            ),
          );

  @override
  Future<void> setPreference(TrackingPreference preference) =>
      collection.put(preference.toRecord());
}

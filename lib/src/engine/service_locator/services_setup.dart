part of 'root_setup.dart';

final _isarSchemas = [
  TrackingPreferenceRecordSchema,
  TrackingSessionRecordSchema,
];

Future<void> _servicesSetup() async {
  _getIt.registerLazySingletonAsync<Isar>(() async {
    final baseDirectory = await getApplicationDocumentsDirectory();
    final directory = join(baseDirectory.path, "database");
    return Isar.open(_isarSchemas, directory: directory);
  });
  await _getIt.isReady<Isar>();
  _getIt.registerLazySingleton<TrackingPreferenceService>(
    () => TrackingPreferenceServiceImpl(_getIt.get()),
  );
  _getIt.registerLazySingleton<TrackingSessionService>(
    () => TrackingSessionServiceImpl(_getIt.get()),
  );

  _getIt.registerLazySingleton(() => TrackingPreferenceCache());
}

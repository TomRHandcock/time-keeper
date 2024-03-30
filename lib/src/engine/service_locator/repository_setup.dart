part of 'root_setup.dart';

Future<void> _repositorySetup() async {
  _getIt.registerLazySingleton<TrackingPreferenceRepository>(
    () => TrackingPreferenceRepositoryImpl(_getIt.get()),
  );
}

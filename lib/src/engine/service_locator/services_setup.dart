part of 'root_setup.dart';

Future<void> _servicesSetup() async {
  _getIt.registerLazySingletonAsync<Store>(() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    return openStore(directory: join(appDirectory.path, "database"));
  });
  await _getIt.isReady<Store>();
}
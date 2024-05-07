part of 'root_setup.dart';

Future<void> _blocSetup() async {
  _getIt.registerFactory(() => DurationSetterCubit(_getIt.get()));
}

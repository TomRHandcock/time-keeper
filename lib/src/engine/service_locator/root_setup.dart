import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_keeper/config/objectbox/objectbox.g.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_cache.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_repository.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_store.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_cubit.dart';

part 'bloc_setup.dart';
part 'use_case_setup.dart';
part 'repository_setup.dart';
part 'services_setup.dart';

GetIt _getIt = GetIt.I;

Future<void> rootSetup() async{
  await _servicesSetup();
  await _repositorySetup();
  await _useCaseSetup();
  await _blocSetup();
}
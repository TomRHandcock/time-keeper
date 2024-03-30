part 'bloc_setup.dart';
part 'use_case_setup.dart';
part 'repository_setup.dart';
part 'services_setup.dart';

Future<void> rootSetup() async{
  await _servicesSetup();
  await _repositorySetup();
  await _useCaseSetup();
  await _blocSetup();
}
import 'package:flutter/material.dart';
import 'package:time_keeper/src/engine/router/router.dart';
import 'package:time_keeper/src/engine/service_locator/root_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rootSetup();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
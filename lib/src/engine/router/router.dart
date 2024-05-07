import 'package:auto_route/auto_route.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/duration_setter_screen.dart';
import 'package:time_keeper/src/ui/screens/home/home_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: DurationSetterRoute.page,
        ),
      ];
}

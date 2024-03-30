import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_keeper/src/engine/router/router.dart';
import 'package:time_keeper/src/ui/widgets/time_keeper_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeContent(
      onSetDurationPressed: () => _onSetDurationPressed(context),
    );
  }

  _onSetDurationPressed(BuildContext context) {
    AutoRouter.of(context).push(const DurationSetterRoute());
  }
}

class HomeContent extends StatelessWidget {
  final Function()? onSetDurationPressed;

  const HomeContent({
    this.onSetDurationPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TimeKeeperButton(
            label: "Set duration",
            onPressed: onSetDurationPressed,
          ),
        ],
      ),
    );
  }
}

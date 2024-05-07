import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_cubit.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_state.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/widgets/duration_picker.dart';
import 'package:time_keeper/src/ui/widgets/animation/animated_state.dart';
import 'package:time_keeper/src/ui/widgets/time_keeper_button.dart';

@RoutePage()
class DurationSetterScreen extends StatelessWidget implements AutoRouteWrapper {
  const DurationSetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DurationSetterCubit, DurationSetterState>(
      listener: _onStateUpdate,
      builder: (_, state) => DurationSetterContent(
        state: state,
        onDurationUpdated: (duration) => _onDurationUpdated(context, duration),
        onSubmitted: () => _onSubmitted(context),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) =>
            GetIt.I.get<DurationSetterCubit>()..fetchInitialPreference(),
        child: this,
      );

  _onStateUpdate(BuildContext context, DurationSetterState state) {
    if(state is DurationSetterStateSubmitted) {
      AutoRouter.of(context).maybePop();
    }
  }

  _onDurationUpdated(BuildContext context, Duration duration) {
    context.read<DurationSetterCubit>().updatePreference(duration);
  }

  _onSubmitted(BuildContext context) {
    context.read<DurationSetterCubit>().setPreference();
  }
}

class DurationSetterContent extends StatelessWidget {
  final DurationSetterState state;
  final Function(Duration duration)? onDurationUpdated;
  final Function()? onSubmitted;

  const DurationSetterContent({
    required this.state,
    this.onDurationUpdated,
    this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedState(
        targetValue: state,
        buildWhen: (oldValue, newValue) =>
            oldValue.runtimeType != newValue.runtimeType,
        builder: (context, targetValue) => switch (targetValue) {
          DurationSetterStateInitial() ||
          DurationSetterStateFetching() =>
            const _Loading(),
          DurationSetterStateReady(:final data) ||
          DurationSetterStateSubmitting(:final data) ||
          DurationSetterStateSubmitted(:final data) =>
            _Data(
              data: data,
              onDurationChanged: onDurationUpdated,
              onSubmitted: onSubmitted,
            ),
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Data extends StatelessWidget {
  final DurationSetterStateData data;
  final Function(Duration duration)? onDurationChanged;
  final Function()? onSubmitted;

  const _Data({
    required this.data,
    this.onDurationChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select time keeping duration",
              textAlign: TextAlign.center,
            ),
          ),
          DurationPicker(
            duration: data.durationPreference,
            onDurationUpdated: onDurationChanged,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TimeKeeperButton(
              label: "Submit",
              onPressed: () => onSubmitted?.call(),
            ),
          ),
        ],
      ),
    );
  }
}

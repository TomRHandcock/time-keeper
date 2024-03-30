import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_cubit.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_state.dart';

@RoutePage()
class DurationSetterScreen extends StatelessWidget implements AutoRouteWrapper {
  const DurationSetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DurationSetterCubit, DurationSetterState>(
      builder: (_, state) => DurationSetterContent(
        state: state,
        onDurationUpdated: (duration) => _onDurationUpdated(context, duration),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) =>
            GetIt.I.get<DurationSetterCubit>()..fetchInitialPreference(),
        child: this,
      );

  _onDurationUpdated(BuildContext context, Duration duration) {
    context.read<DurationSetterCubit>().updatePreference(duration);
  }
}

class DurationSetterContent extends StatelessWidget {
  final DurationSetterState state;
  final Function(Duration duration)? onDurationUpdated;

  const DurationSetterContent({
    required this.state,
    this.onDurationUpdated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (state) {
        DurationSetterStateInitial() ||
        DurationSetterStateFetching() =>
          const _Loading(),
        DurationSetterStateReady(:final data) ||
        DurationSetterStateSubmitting(:final data) ||
        DurationSetterStateSubmitted(:final data) =>
          _Data(data: data),
      },
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

  const _Data({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Current duration:",
          textAlign: TextAlign.center,
        ),
        Text(
          data.durationPreference.toString(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

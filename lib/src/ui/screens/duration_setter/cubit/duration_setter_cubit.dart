import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_repository.dart';
import 'package:time_keeper/src/engine/utils/future_utils.dart';
import 'package:time_keeper/src/ui/screens/duration_setter/cubit/duration_setter_state.dart';

class DurationSetterCubit extends Cubit<DurationSetterState> {
  static const _defaultDurationPreference = Duration(hours: 7, minutes: 30);

  final TrackingPreferenceRepository _trackingPreferenceRepository;

  DurationSetterCubit(this._trackingPreferenceRepository)
      : super(const DurationSetterState.initial());

  Future<void> fetchInitialPreference() async {
    if (_isLoading(state)) {
      return;
    }
    emit(const DurationSetterState.fetching());
    final preference =
        await _trackingPreferenceRepository.fetchPreference().successOrNull();
    emit(
      DurationSetterState.ready(
        data: DurationSetterStateData(
          durationPreference:
              preference?.duration ?? _defaultDurationPreference,
        ),
      ),
    );
  }

  void updatePreference(Duration duration) {
    final localState = state;
    if (_isLoading(localState) || localState is! DurationSetterStateReady) {
      return;
    }
    emit(DurationSetterState.ready(
      data: localState.data.copyWith(durationPreference: duration),
    ));
  }

  Future<void> setPreference() async {
    final localState = state;
    if (_isLoading(localState) || localState is! DurationSetterStateReady) {
      return;
    }
    emit(DurationSetterState.submitting(data: localState.data));
    try {
      await _trackingPreferenceRepository.setPreference(
        TrackingPreference(duration: localState.data.durationPreference),
      );
    } catch (_) {
      // Ignore errors.
    } finally {
      emit(DurationSetterState.success(data: localState.data));
    }
  }

  static bool _isLoading(DurationSetterState state) => switch (state) {
        DurationSetterStateFetching() => true,
        DurationSetterStateSubmitting() => true,
        _ => false,
      };
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'duration_setter_state.freezed.dart';

@freezed
sealed class DurationSetterState with _$DurationSetterState {

  const factory DurationSetterState.initial() = DurationSetterStateInitial;

  const factory DurationSetterState.fetching() = DurationSetterStateFetching;

  const factory DurationSetterState.ready({
    required DurationSetterStateData data,
  }) = DurationSetterStateReady;

  const factory DurationSetterState.submitting({
    required DurationSetterStateData data,
  }) = DurationSetterStateSubmitting;

  const factory DurationSetterState.success({
    required DurationSetterStateData data,
  }) = DurationSetterStateSubmitted;
}

@freezed
class DurationSetterStateData with _$DurationSetterStateData {
  const factory DurationSetterStateData({
    required Duration durationPreference,
  }) = _DurationSetterStateData;
}

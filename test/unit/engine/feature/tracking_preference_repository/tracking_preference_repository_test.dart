import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_repository.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_store.dart';

import 'tracking_preference_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TrackingPreferenceService>()])
void main() async {
  group("Tracking Preference Repository Unit Tests", () {
    final mockService = MockTrackingPreferenceService();
    late TrackingPreferenceRepositoryImpl sut;

    setUp(() {
      reset(mockService);
      sut = TrackingPreferenceRepositoryImpl(mockService);
    });

    test("fetchPreference - upon storage success - answers", () async {
      // Setup
      when(mockService.getPreference()).thenAnswer(
        (_) async => const TrackingPreference(
          duration: Duration(hours: 7, minutes: 30),
        ),
      );

      // Run test
      final result = await sut.fetchPreference();

      // Verify
      expect(
        result,
        const TrackingPreference(
          duration: Duration(hours: 7, minutes: 30),
        ),
      );
      verify(mockService.getPreference()).called(1);
    });

    test("setPreference - upon storage success - completes", () async {
      // Setup
      when(mockService.setPreference(any)).thenAnswer((_) async {});

      // Run test & verify
      await expectLater(
        sut.setPreference(
          const TrackingPreference(duration: Duration(hours: 7, minutes: 30)),
        ),
        completes,
      );
      verify(
        mockService.setPreference(const TrackingPreference(
          duration: Duration(hours: 7, minutes: 30),
        )),
      ).called(1);
    });
  });
}

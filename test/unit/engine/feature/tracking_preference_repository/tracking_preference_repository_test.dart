import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/models.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_cache.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_repository.dart';
import 'package:time_keeper/src/engine/feature/tracking_preference/tracking_preference_store.dart';

import 'tracking_preference_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TrackingPreferenceService>(),
  MockSpec<TrackingPreferenceCache>()
])
void main() async {
  group("Tracking Preference Repository Unit Tests", () {
    final mockCache = MockTrackingPreferenceCache();
    final mockService = MockTrackingPreferenceService();
    late TrackingPreferenceRepositoryImpl sut;

    const fullTimeFixture = TrackingPreference(
      duration: Duration(hours: 7, minutes: 30),
    );

    setUp(() {
      reset(mockService);
      sut = TrackingPreferenceRepositoryImpl(mockCache, mockService);
    });

    test("fetchPreference - no memory - upon storage success - answers storage",
        () async {
      // Setup
      when(mockService.getPreference())
          .thenAnswer((_) async => fullTimeFixture);

      // Run test
      final result = await sut.fetchPreference();

      // Verify
      expect(result, fullTimeFixture);
      verify(mockCache.fetchValue()).called(1);
      verify(mockService.getPreference()).called(1);
    });

    test("fetchPreference - memory success - answers memory", () async {
      // Setup
      when(mockCache.fetchValue()).thenAnswer(
        (_) async => const TrackingPreference(duration: Duration(hours: 5)),
      );

      // Run test
      final result = await sut.fetchPreference();

      // Verify
      expect(result, const TrackingPreference(duration: Duration(hours: 5)));
      verify(mockCache.fetchValue()).called(1);
      verifyNever(mockService.getPreference());
    });

    test("setPreference - upon storage success - completes", () async {
      // Setup
      when(mockService.setPreference(any)).thenAnswer((_) async {});

      // Run test & verify
      await expectLater(
        sut.setPreference(fullTimeFixture),
        completes,
      );
      verify(mockService.setPreference(fullTimeFixture)).called(1);
      verify(mockCache.setValue(fullTimeFixture));
    });
  });
}

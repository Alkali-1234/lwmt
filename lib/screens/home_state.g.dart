// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentMonth)
final currentMonthProvider = CurrentMonthProvider._();

final class CurrentMonthProvider
    extends $AsyncNotifierProvider<CurrentMonth, Month> {
  CurrentMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMonthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMonthHash();

  @$internal
  @override
  CurrentMonth create() => CurrentMonth();
}

String _$currentMonthHash() => r'25c28986260e7572303d7d7c6ffd2e208d878c6e';

abstract class _$CurrentMonth extends $AsyncNotifier<Month> {
  FutureOr<Month> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Month>, Month>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Month>, Month>,
              AsyncValue<Month>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(currentTotal)
final currentTotalProvider = CurrentTotalProvider._();

final class CurrentTotalProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  CurrentTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentTotalHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return currentTotal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$currentTotalHash() => r'dc0ffbde7bdeab77ba71d59041b4839fea94f878';

@ProviderFor(currentDailyTotal)
final currentDailyTotalProvider = CurrentDailyTotalProvider._();

final class CurrentDailyTotalProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  CurrentDailyTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDailyTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDailyTotalHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return currentDailyTotal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$currentDailyTotalHash() => r'78ad37d97a3d0db5afb97c007fb8b051a5f36c2d';

@ProviderFor(CustomDate)
final customDateProvider = CustomDateProvider._();

final class CustomDateProvider extends $NotifierProvider<CustomDate, int> {
  CustomDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customDateHash();

  @$internal
  @override
  CustomDate create() => CustomDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$customDateHash() => r'158f469cfcd2af659476edef5a8ee9f70780fdc7';

abstract class _$CustomDate extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

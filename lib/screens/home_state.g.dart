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

String _$currentMonthHash() => r'6cf0246988253e0fe5456a00bbe44cc4f3beb19c';

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

String _$currentTotalHash() => r'f8ae11eb6caf03b6c12afb834f4c64c1fff26382';

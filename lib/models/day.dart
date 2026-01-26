import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'day.freezed.dart';
// optional: Since our class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'day.g.dart';

//* Mutable data class storing the exact date of i amount of spending
@unfreezed
abstract class Day with _$Day {
  factory Day({required int day, required List<(String, int)> spendings}) =
      _Day;

  factory Day.fromJson(Map<String, Object?> json) => _$DayFromJson(json);
}

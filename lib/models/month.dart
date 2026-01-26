import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'day.dart';

part 'month.freezed.dart';
// optional: Since our class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'month.g.dart';

//* Mutable data class storing the month it is projected and the days which is used to query spending
@unfreezed
abstract class Month with _$Month {
  factory Month({
    required int allocation,
    required int month,
    required int year,
    required List<Day> days,
  }) = _Month;

  factory Month.fromJson(Map<String, Object?> json) => _$MonthFromJson(json);
}

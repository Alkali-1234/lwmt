import 'dart:convert';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:lwmt/models/day.dart';
import 'package:lwmt/models/month.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_state.g.dart';

@Riverpod(keepAlive: true)
class CurrentMonth extends _$CurrentMonth {
  late Box<String> box;

  Future<void> updateDay(Day day) async {
    if (!state.hasValue) {
      return;
    }
    var mo = state.value!;
    int idx = mo.days.indexWhere((day) => day.day == day.day);
    if (idx == -1) {
      return;
    }
    mo.days[idx] = day;
    await updateMonth(mo);
  }

  ///* This will invalidate the provider updateing the value
  Future<void> updateMonth(Month nm) async {
    await box.delete('${nm.year}/${nm.month}');
    await box.put('${nm.year}/${nm.month}', jsonEncode(nm.toJson()));
    ref.invalidateSelf();
    ref.read(currentMonthProvider);
  }

  @override
  FutureOr<Month> build() async {
    var dt = DateTime.now();
    box = await Hive.openBox<String>('spending_data');
    var keys = box.keys;
    if (box.isEmpty || !keys.contains('${dt.year}/${dt.month}')) {
      //* Initialize data
      //* Generates N amount of days which is the dfference in days from the start of the month to next month
      int diff = DateTime(dt.year, dt.month)
          .difference(
            DateTime(
              //* Conditionals for December
              dt.month != 12 ? dt.year : dt.year + 1,
              dt.month != 12 ? dt.month + 1 : 1,
            ),
          )
          .inDays;
      List<Day> days = List.generate(
        diff.abs(),
        (index) => Day(day: index, spendings: []),
      );
      var mo = Month(allocation: 0, month: dt.month, year: dt.year, days: days);
      await box.put('${dt.year}/${dt.month}', jsonEncode(mo.toJson()));
      return mo;
    }
    //* Invalid key check already passed
    return Month.fromJson(jsonDecode(box.get('${dt.year}/${dt.month}')!));
  }
}

@riverpod
int currentTotal(Ref ref) {
  final month = ref.watch(currentMonthProvider);
  if (!month.hasValue) return 0;
  int res = 0;
  for (var e in month.value!.days) {
    for (var i in e.spendings) {
      res += i.$2;
    }
  }
  return month.value!.allocation - res;
}

@riverpod
int currentDailyTotal(Ref ref) {
  final currentTotal = ref.watch(currentTotalProvider);
  var dt = DateTime.now();
  int daysLeft = DateTime(
    dt.month != 12 ? dt.year : dt.year + 1,
    dt.month != 12 ? dt.month + 1 : 1,
  ).difference(dt).inDays;

  return (currentTotal / daysLeft.abs()).floor();
}

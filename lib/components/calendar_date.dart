import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lwmt/screens/home_state.dart';

class CalendarDate extends ConsumerStatefulWidget {
  const CalendarDate({super.key, required this.day});
  final int day;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarDateState();
}

class _CalendarDateState extends ConsumerState<CalendarDate> {
  bool hovering = false;
  @override
  Widget build(BuildContext context) {
    var customDate = ref.watch(customDateProvider);
    var customDateNotifier = ref.watch(customDateProvider.notifier);
    return MouseRegion(
      onEnter: (event) => setState(() => hovering = true),
      onExit: (event) => setState(() => hovering = false),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: widget.day == DateTime.now().day
              ? Colors.black
              : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
            side: BorderSide(
              color: hovering
                  ? Colors.white
                  : customDate == widget.day
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black,
            ),
          ),
        ),
        onPressed: () {
          if (DateTime.now().day == widget.day) {
            customDateNotifier.setCustomDate(-1);
          } else {
            customDateNotifier.setCustomDate(widget.day);
          }
        },
        child: Text(
          widget.day.toString(),
          style: TextStyle(
            fontFamily: 'GoogleSansFlex',
            fontSize: 24,
            fontWeight: widget.day != DateTime.now().day
                ? FontWeight.w300
                : FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

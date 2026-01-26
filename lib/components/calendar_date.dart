import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return MouseRegion(
      onEnter: (event) => setState(() => hovering = true),
      onExit: (event) => setState(() => hovering = false),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: widget.day == DateTime.now().day
              ? Colors.black
              : Colors.black,
          shape: CircleBorder(
            side: BorderSide(color: hovering ? Colors.white : Colors.black),
          ),
        ),
        onPressed: () {},
        child: Text(
          widget.day.toString(),
          style: TextStyle(
            fontFamily: 'GoogleSansFlex',
            fontSize: 36,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

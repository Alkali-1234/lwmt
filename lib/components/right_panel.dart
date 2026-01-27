import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lwmt/components/calendar_date.dart';

class RightPanel extends ConsumerStatefulWidget {
  const RightPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RightPanelState();
}

class _RightPanelState extends ConsumerState<RightPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Calendar",
            style: TextStyle(
              fontFamily: 'GoogleSansFlex',
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: double.infinity,
                ),
                child: CalendarWidget(),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  List<List<int>> matrix = [];
  void buildCalendar() {
    var dt = DateTime.now();
    int moStart = DateTime(dt.year, dt.month).weekday;
    int daysAmount = DateTime(
      dt.month != 12 ? dt.year : dt.year + 1,
      dt.month != 12 ? dt.month + 1 : 1,
    ).difference(DateTime(dt.year, dt.month)).inDays;
    //* offset first row
    matrix.add(List.generate(moStart - 1, (_) => 0));
    int idx = 1;
    int rowIdx = 0; //* 0 idx
    while (idx <= daysAmount) {
      if (matrix[rowIdx].length >= 7) {
        rowIdx++;
        matrix.add([]);
      }
      matrix[rowIdx].add(idx);
      idx++;
    }
    //* Fill Remaining last
    if (matrix.last.length != 7) {
      matrix.last.addAll(List.filled(7 - matrix.length, 0));
    }
  }

  @override
  void initState() {
    super.initState();
    buildCalendar();
  }

  final List<String> dayLabels = ["M", "T", "W", "Th", "F", "S", "Su"];

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      children: [
        for (var label in dayLabels)
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        for (var row in matrix) ...[
          for (var e in row) ...[
            if (e == 0) SizedBox(),
            if (e != 0) CalendarDate(day: e),
          ],
        ],
      ],
    );
  }
}

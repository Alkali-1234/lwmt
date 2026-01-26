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
    return Column(children: [CalendarDate(day: DateTime.now().day)]);
  }
}

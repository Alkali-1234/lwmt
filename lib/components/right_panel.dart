import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lwmt/components/calendar_date.dart';
import 'package:lwmt/components/cursor_fedback.dart';
import 'package:lwmt/screens/home_state.dart';

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
          //* Auto & Budget
          Row(
            children: [
              CursorFedback(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (c) => SetAutoModal(),
                  ),
                  label: Text(
                    "Auto",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  icon: Icon(Icons.add_rounded, color: Colors.black, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              ConfigBudgetButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class ConfigBudgetButton extends StatefulWidget {
  const ConfigBudgetButton({super.key});

  @override
  State<ConfigBudgetButton> createState() => _ConfigBudgetButtonState();
}

class _ConfigBudgetButtonState extends State<ConfigBudgetButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => hover = true),
      onExit: (event) => setState(() => hover = false),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          backgroundColor: hover ? Colors.white : Colors.black,
          foregroundColor: hover ? Colors.black : Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => BudgetSetModal(),
        ),
        label: Text("Budget", style: TextStyle(fontSize: 16)),
        icon: Icon(Icons.settings_rounded, size: 20),
      ),
    );
  }
}

class BudgetSetModal extends StatefulWidget {
  const BudgetSetModal({super.key});

  @override
  State<BudgetSetModal> createState() => _BudgetSetModalState();
}

class _BudgetSetModalState extends State<BudgetSetModal> {
  TextEditingController controller = .new();
  void submit(WidgetRef ref) {
    if (controller.text.isEmpty) {
      return;
    }
    int? parse = int.tryParse(controller.text);
    if (parse == null) {
      return;
    }
    var mo = ref.read(currentMonthProvider);
    if (mo.value == null) return;
    ref
        .read(currentMonthProvider.notifier)
        .updateMonth(mo.value!.copyWith(allocation: parse));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: .min,
            children: [
              Text(
                "Set your budget.",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "xxx.xxx.xxx,xx",
                        hintStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "IDR",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  return CursorFedback(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                        ),
                        onPressed: () {
                          submit(ref);
                          Navigator.of(context).pop();
                        },
                        label: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        icon: Icon(
                          Icons.check_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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

class SetAutoModal extends ConsumerStatefulWidget {
  const SetAutoModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetAutoModalState();
}

class _SetAutoModalState extends ConsumerState<SetAutoModal> {
  TextEditingController controllerValue = .new();
  TextEditingController controllerInfo = .new();
  void submit() {
    if (controllerInfo.text.isEmpty || controllerValue.text.isEmpty) {
      return;
    }
    int? parse = int.tryParse(controllerValue.text);
    if (parse == null) return;
    var mo = ref.read(currentMonthProvider).value;
    if (mo == null) return;
    for (var day in mo.days) {
      day.spendings.add((controllerInfo.text, parse));
    }
    ref.read(currentMonthProvider.notifier).updateMonth(mo);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(32),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: .min,
            children: [
              Text(
                "Set Auto",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controllerInfo,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: "item info",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controllerValue,
                style: TextStyle(fontSize: 20),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "value",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              CursorFedback(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      submit();
                      Navigator.of(context).pop();
                    },
                    label: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    icon: Icon(
                      Icons.check_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lwmt/components/cursor_fedback.dart';
import 'package:lwmt/components/right_panel.dart';
import 'package:lwmt/components/secondary_button.dart';
import 'package:lwmt/models/day.dart';
import 'package:lwmt/models/month.dart';
import 'package:lwmt/screens/home_state.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    var currentMonth = ref.watch(currentMonthProvider);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (!currentMonth.hasValue) {
              return Center(
                child: Text(
                  "Loading data",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: LeftPanel()),
                Container(
                  height: constraints.maxHeight - 80,
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                Expanded(child: RightPanel()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LeftPanel extends ConsumerStatefulWidget {
  const LeftPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeftPanelState();
}

class _LeftPanelState extends ConsumerState<LeftPanel> {
  int currentDay = DateTime.now().day;
  @override
  Widget build(BuildContext context) {
    var currentMonth = ref.watch(currentMonthProvider);
    var currentTotal = ref.watch(currentTotalProvider);
    return Padding(
      padding: const EdgeInsetsGeometry.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "IDR ${currentTotal.toString()},00",
            style: TextStyle(
              fontFamily: 'GoogleSansFlex',
              fontWeight: FontWeight.w700,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "IDR ${currentTotal.toString()},00",
            style: TextStyle(fontFamily: 'GoogleSansFlex', fontSize: 36),
          ),
          const SizedBox(height: 48),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "today's spend = ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                ),
                TextSpan(
                  text: "Unimplemented",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          //* List Items
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CreateSpendWidget(day: currentDay),
                ),
                //* Current month -> days where today -> spendings -> map to widgets
                ...currentMonth.value!.days
                    .firstWhere((d) => d.day == currentDay)
                    .spendings
                    .map<Widget>((day) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: EditSpendWidget(
                          key: ValueKey(day),
                          spend: day,
                          day: currentDay,
                          onChange: (s) {},
                          onDelete: () {},
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateSpendWidget extends ConsumerStatefulWidget {
  const CreateSpendWidget({super.key, required this.day});
  final int day;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateSpendWidgetState();
}

class _CreateSpendWidgetState extends ConsumerState<CreateSpendWidget> {
  TextEditingController controllerInfo = TextEditingController();
  TextEditingController controllerValue = TextEditingController();

  void insertSpending(Day? day) {
    if (controllerInfo.text.isEmpty ||
        day == null ||
        controllerValue.text.isEmpty) {
      return;
    }
    int? parsedValue = int.tryParse(controllerValue.text);
    if (parsedValue == null) return;
    if (day.spendings.contains((controllerInfo.text, parsedValue))) {
      return;
    }
    ref
        .read(currentMonthProvider.notifier)
        .updateDay(
          day.copyWith(
            spendings: [(controllerInfo.text, parsedValue), ...day.spendings],
          ),
        );
    setState(() {
      controllerInfo.text = "";
      controllerValue.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentMonth = ref.watch(currentMonthProvider);
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: ItemInfoTextField(controller: controllerInfo),
                ),
                Expanded(
                  flex: 2,
                  child: ItemValueTextField(controller: controllerValue),
                ),
              ],
            ),
          ),
          /*
            *BUTTON CODE
           */
          Expanded(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
              child: SizedBox(
                height: 40,
                child: CursorFedback(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () => insertSpending(
                      currentMonth.value?.days.firstWhere(
                        (d) => d.day == widget.day,
                      ),
                    ),
                    label: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditSpendWidget extends ConsumerStatefulWidget {
  const EditSpendWidget({
    super.key,
    required this.spend,
    required this.onChange,
    required this.onDelete,
    required this.day,
  });
  final (String, int) spend;
  final Function((String, int)) onChange;
  final Function onDelete;
  final int day;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditSpendWidgetState();
}

class _EditSpendWidgetState extends ConsumerState<EditSpendWidget> {
  late TextEditingController controllerInfo = TextEditingController(
    text: widget.spend.$1,
  );
  late TextEditingController controllerValue = TextEditingController(
    text: widget.spend.$2.toString(),
  );
  bool hovering = false;
  void trashItem() {
    final mo = ref.read(currentMonthProvider);
    if (mo.hasValue == false) return;
    var nm = mo.value!;
    nm.days
        .firstWhere((d) => d.day == widget.day)
        .spendings
        .remove(widget.spend);
    ref.read(currentMonthProvider.notifier).updateMonth(nm);
  }

  void updateItem() {
    final mo = ref.read(currentMonthProvider);
    if (mo.hasValue == false) return;
    var nm = mo.value!;
    var li = nm.days
        .firstWhere((d) => d.day == widget.day)
        .spendings
        .map(
          (e) => e != widget.spend
              ? e
              : (
                  controllerInfo.text,
                  int.tryParse(controllerValue.text) ?? 10000,
                ),
        );
    nm.days.firstWhere((d) => d.day == DateTime.now().day).spendings = li
        .toList();
    ref.read(currentMonthProvider.notifier).updateMonth(nm.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => hovering = true),
      onExit: (event) => setState(() => hovering = false),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 3,
                    child: ItemInfoTextField(
                      controller: controllerInfo,
                      onChanged: (v) => setState(() {}),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ItemValueTextField(
                      controller: controllerValue,
                      onChanged: (v) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
            //TODO: (1) Trash item fun (2) edit item fun
            Expanded(
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: hovering ? 1 : 0,
                    child:
                        (
                              controllerInfo.text,
                              int.tryParse(controllerValue.text),
                            ) ==
                            widget.spend
                        //* Show trash if not edited
                        ? SecondaryButton(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.red,
                            onPressed: () {
                              trashItem();
                            },
                            child: Icon(
                              Icons.delete_outline_outlined,
                              size: 24,
                            ),
                          )
                        : SecondaryButton(
                            onPressed: () {
                              updateItem();
                            },
                            child: Icon(Icons.check_rounded, size: 24),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemValueTextField extends StatelessWidget {
  const ItemValueTextField({
    super.key,
    required this.controller,
    this.onChanged,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      controller: controller,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'GoogleSansFlex',
        fontWeight: FontWeight.w700,
      ),
      cursorHeight: 16,
      decoration: InputDecoration(
        hintText: "IDR",
        hintStyle: TextStyle(
          fontFamily: 'GoogleSansFlex',
          color: Colors.grey,
          fontWeight: FontWeight.w700,
        ),
        contentPadding: const EdgeInsets.only(left: 4),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

class ItemInfoTextField extends StatelessWidget {
  const ItemInfoTextField({
    super.key,
    required this.controller,
    this.onChanged,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(fontFamily: 'GoogleSansFlex'),
      cursorHeight: 16,
      decoration: InputDecoration(
        hintText: "item info",
        hintStyle: TextStyle(fontFamily: 'GoogleSansFlex', color: Colors.grey),
        contentPadding: const EdgeInsets.only(left: 8),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 80, 80, 80)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

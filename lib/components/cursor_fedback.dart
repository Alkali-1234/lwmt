import 'package:flutter/material.dart';

class CursorFedback extends StatefulWidget {
  const CursorFedback({super.key, required this.child});
  final Widget child;

  @override
  State<CursorFedback> createState() => _CursorFedbackState();
}

class _CursorFedbackState extends State<CursorFedback> {
  Tween<double> tween = Tween(begin: 0, end: 0);
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        setState(() {
          tween = Tween(begin: 1, end: -0.5);
        });
      },
      onPointerUp: (details) {
        setState(() {
          tween = Tween(begin: -0.5, end: 1);
        });
      },
      // onPointerSignal: (_) {
      //   setState(() {
      //     tween = Tween(begin: 1, end: 0.7);
      //   });
      // },
      // onPointerCancel: (_) {
      //   setState(() {
      //     tween = Tween(begin: 0.7, end: 1);
      //   });
      // },
      child: MouseRegion(
        onEnter: (event) => setState(() => tween = Tween(begin: 0, end: 1)),
        onExit: (event) => setState(() => tween = Tween(begin: 1, end: 0)),
        child: TweenAnimationBuilder(
          curve: Curves.easeOut,
          tween: tween,
          duration: const Duration(milliseconds: 150),
          builder: (context, animation, child) {
            return Transform.scale(scale: (animation * 0.05) + 1, child: child);
          },
          child: widget.child,
        ),
      ),
    );
  }
}

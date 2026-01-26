import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
  });
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => hovering = true),
      onExit: (event) => setState(() => hovering = false),
      child: ElevatedButton(
        onPressed: () => widget.onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: hovering
              ? widget.foregroundColor
              : widget.backgroundColor,
          foregroundColor: hovering
              ? widget.backgroundColor
              : widget.foregroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.foregroundColor, width: 2),
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

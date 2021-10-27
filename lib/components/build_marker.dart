import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';

class BuildMarker extends StatelessWidget {
  final dynamic agenda;
  final double width;
  const BuildMarker({
    Key? key,
    this.agenda,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? dynamicColor;

    if (agenda.length == 1) {
      dynamicColor = Colors.blueGrey.shade200.withOpacity(0.25);
    } else if (agenda.length == 2) {
      dynamicColor = Colors.blueGrey.shade200.withOpacity(0.75);
    } else if (agenda.length == 3) {
      dynamicColor = Colors.yellow.withOpacity(0.75);
    } else if (agenda.length >= 4) {
      dynamicColor = Colors.red.withOpacity(0.75);
    } else {
      dynamicColor = Colors.transparent;
    }

    return Container(
      margin: EdgeInsets.all(width <= breakpoint ? width * 0.004 : width * 0.002),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: dynamicColor,
          width: 2
        )
      ),
    );
  }
}
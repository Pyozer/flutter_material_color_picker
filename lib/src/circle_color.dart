import 'package:flutter/material.dart';

typedef OnColorChoose = void Function(Color color);

class CircleColor extends StatelessWidget {
  static const double _kColorElevation = 4.0;

  final bool isSelected;
  final Color color;
  final OnColorChoose? onColorChoose;
  final double circleSize;
  final double? elevation;
  final IconData? iconSelected;

  const CircleColor({
    Key? key,
    required this.color,
    required this.circleSize,
    this.onColorChoose,
    this.isSelected = false,
    this.elevation = _kColorElevation,
    this.iconSelected,
  })  : assert(circleSize >= 0, "You must provide a positive size"),
        assert(!isSelected || (isSelected && iconSelected != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final icon = brightness == Brightness.light ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onColorChoose != null ? () => onColorChoose!(color) : null,
      child: Material(
        elevation: elevation ?? _kColorElevation,
        shape: const CircleBorder(),
        child: CircleAvatar(
          radius: circleSize / 2,
          backgroundColor: color,
          child: isSelected ? Icon(iconSelected, color: icon) : null,
        ),
      ),
    );
  }
}

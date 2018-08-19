import 'package:flutter/material.dart';

class CircleColor extends StatelessWidget {
  static const double _kBorderWidth = 2.0;
  static const double _kBorderWidthSelected = 5.0;
  static const double _kColorElevation = 4.0;

  static const ShapeBorder _kShape = const CircleBorder(
      side: const BorderSide(color: Colors.black12, width: _kBorderWidth));

  static const ShapeBorder _kShapeSelected = const CircleBorder(
      side: const BorderSide(
          color: Colors.black54, width: _kBorderWidthSelected));

  final bool isSelected;
  final Color color;
  final VoidCallback onColorChoose;
  final double circleSize;
  final double elevation;
  final ShapeBorder shape;
  final ShapeBorder shapeSelected;

  const CircleColor(
      {Key key,
      this.isSelected,
      @required this.color,
      this.onColorChoose,
      @required this.circleSize,
      this.elevation = _kColorElevation,
      this.shape = _kShape,
      this.shapeSelected = _kShapeSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: elevation,
        shape: (isSelected ?? false) ? shapeSelected : shape,
        color: color,
        child: InkWell(
            onTap: onColorChoose,
            child: Container(
                width: circleSize,
                height: circleSize,
                color: Colors.transparent)));
  }
}

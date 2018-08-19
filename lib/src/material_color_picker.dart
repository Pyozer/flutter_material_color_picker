import 'package:color_picker/src/circle_color.dart';
import 'package:flutter/material.dart';

const List<MaterialColor> materialColors = const <MaterialColor>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey
];

class MaterialColorPicker extends StatefulWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChange;
  final VoidCallback onColorSelected;
  final WrapAlignment colorsAlignement;
  final List<MaterialColor> colors;

  const MaterialColorPicker(
      {Key key,
      this.selectedColor,
      this.onColorChange,
      this.onColorSelected,
      this.colorsAlignement = WrapAlignment.start,
      this.colors = materialColors})
      : super(key: key);

  @override
  _MaterialColorPickerState createState() => _MaterialColorPickerState();
}

class _MaterialColorPickerState extends State<MaterialColorPicker> {
  static const double _kCircleColorSize = 47.0;
  static const double _kPadding = 9.0;

  MaterialColor _mainColor;
  Color _shadeColor;
  bool _isMainSelection;

  @override
  void initState() {
    super.initState();
    _mainColor = widget.colors[0];
    _shadeColor = _mainColor.shade500;
    _isMainSelection = true;
  }

  void _onMainColorSelected(MaterialColor color) {
    setState(() {
      _mainColor = color;
      _shadeColor = _mainColor.shade500;
      _isMainSelection = false;
    });
  }

  void _onShadeColorSelected(Color color) {
    setState(() {
      _shadeColor = color;
    });
    widget.onColorChange(color);
  }

  void _onBack() {
    setState(() {
      _isMainSelection = true;
    });
  }

  List<Widget> _buildListMainColor(List<MaterialColor> colors) {
    List<Widget> circles = [];
    for (final color in colors) {
      final isSelected = _mainColor == color;

      circles.add(CircleColor(
          color: color,
          circleSize: _kCircleColorSize,
          onColorChoose: () => _onMainColorSelected(color),
          isSelected: isSelected));
    }

    return circles;
  }

  List<Color> _getMaterialColorShades(MaterialColor color) {
    return [
      color.shade50,
      color.shade100,
      color.shade200,
      color.shade300,
      color.shade400,
      color.shade500,
      color.shade600,
      color.shade700,
      color.shade800,
      color.shade900
    ];
  }

  List<Widget> _buildListShadesColor(MaterialColor color) {
    List<Widget> circles = [];

    circles.add(IconButton(icon: Icon(Icons.arrow_back), onPressed: _onBack));

    final shades = _getMaterialColorShades(color);
    for (final color in shades) {
      final isSelected = _shadeColor == color;

      circles.add(CircleColor(
          color: color,
          circleSize: _kCircleColorSize,
          onColorChoose: () => _onShadeColorSelected(color),
          isSelected: isSelected));
    }
    return circles;
  }

  @override
  Widget build(BuildContext context) {
    final listChildren = _isMainSelection
        ? _buildListMainColor(widget.colors)
        : _buildListShadesColor(_mainColor);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
            runSpacing: _kPadding,
            spacing: _kPadding,
            children: listChildren,
            verticalDirection: VerticalDirection.down,
            alignment: widget.colorsAlignement));
  }
}

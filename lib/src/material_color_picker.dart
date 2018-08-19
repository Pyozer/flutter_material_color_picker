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
  final WrapAlignment colorsAlignment;
  final List<MaterialColor> colors;

  const MaterialColorPicker(
      {Key key,
      this.selectedColor,
      this.onColorChange,
      this.colorsAlignment = WrapAlignment.start,
      this.colors = materialColors})
      : assert(colors != null),
        super(key: key);

  @override
  _MaterialColorPickerState createState() => _MaterialColorPickerState();
}

class _MaterialColorPickerState extends State<MaterialColorPicker> {
  static const double _kCircleColorSize = 47.0;
  static const double _kPadding = 9.0;

  static final _defaultValue = materialColors[0];

  MaterialColor _mainColor;
  Color _shadeColor;
  bool _isMainSelection;

  @override
  void initState() {
    super.initState();
    _initSelectedValue();
  }

  @protected
  void didUpdateWidget(covariant MaterialColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initSelectedValue();
  }

  void _initSelectedValue() {
    Color shadeColor = widget.selectedColor ?? _defaultValue;
    MaterialColor mainColor = _findMainColor(shadeColor);

    if (mainColor == null) {
      mainColor = (widget.colors != null) ? widget.colors[0] : _defaultValue;
      shadeColor = mainColor.shade500;
    }

    setState(() {
      _mainColor = mainColor;
      _shadeColor = shadeColor;
      _isMainSelection = true;
    });
  }

  MaterialColor _findMainColor(Color shadeColor) {
    for (final mainColor in widget.colors)
      if (_isShadeOfMain(mainColor, shadeColor)) return mainColor;

    return null;
  }

  bool _isShadeOfMain(MaterialColor mainColor, Color shadeColor) {
    List<Color> shades = _getMaterialColorShades(mainColor);

    for (var shade in shades) if (shade == shadeColor) return true;

    return false;
  }

  void _onMainColorSelected(MaterialColor color) {
    var isShadeOfMain = _isShadeOfMain(color, _shadeColor);

    setState(() {
      _mainColor = color;
      _shadeColor = isShadeOfMain ? _shadeColor : color.shade500;
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
            alignment: widget.colorsAlignment));
  }
}

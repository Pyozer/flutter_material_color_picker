import 'package:flutter_material_color_picker/src/circle_color.dart';
import 'package:flutter_material_color_picker/src/colors.dart';
import 'package:flutter/material.dart';

class MaterialColorPicker extends StatefulWidget {
  final Color? selectedColor;
  final ValueChanged<Color>? onColorChange;
  final ValueChanged<ColorSwatch?>? onMainColorChange;
  final List<ColorSwatch>? colors;
  @Deprecated('No longer used')
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool allowShades;
  final bool onlyShadeSelection;
  final double circleSize;
  final double spacing;
  final IconData iconSelected;
  final VoidCallback? onBack;
  final double? elevation;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  const MaterialColorPicker({
    Key? key,
    this.selectedColor,
    this.onColorChange,
    this.onMainColorChange,
    this.colors,
    this.shrinkWrap = true,
    this.physics,
    this.allowShades = true,
    this.onlyShadeSelection = false,
    this.iconSelected = Icons.check,
    this.circleSize = 45.0,
    this.spacing = 9.0,
    this.onBack,
    this.elevation,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.center,
    this.crossAxisAlignment = WrapCrossAlignment.center,
  }) : super(key: key);

  @override
  _MaterialColorPickerState createState() => _MaterialColorPickerState();
}

class _MaterialColorPickerState extends State<MaterialColorPicker> {
  final _defaultValue = materialColors[0];

  List<ColorSwatch> _colors = materialColors;

  late ColorSwatch _mainColor;
  late Color _shadeColor;
  bool _isMainSelection = true;

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
    _colors = widget.colors ?? materialColors;

    Color shadeColor = widget.selectedColor ?? _defaultValue;
    ColorSwatch? mainColor = _findMainColor(shadeColor);

    // If mainColor not found from shade, so mean that shade is wrong
    if (mainColor == null) {
      mainColor = _colors[0];
      shadeColor = mainColor[500] ?? mainColor[400]!;
    }
    setState(() {
      _mainColor = mainColor!;
      _shadeColor = shadeColor;
      _isMainSelection = true;
    });
  }

  ColorSwatch? _findMainColor(Color shadeColor) {
    for (final ColorSwatch mainColor in _colors)
      if (_isShadeOfMain(mainColor, shadeColor)) return mainColor;

    return (shadeColor is ColorSwatch && _colors.contains(shadeColor))
        ? shadeColor
        : null;
  }

  bool _isShadeOfMain(ColorSwatch mainColor, Color shadeColor) {
    for (final shade in _getMaterialColorShades(mainColor)) {
      if (shade == shadeColor) return true;
    }
    return false;
  }

  void _onMainColorSelected(ColorSwatch color) {
    var isShadeOfMain = _isShadeOfMain(color, _shadeColor);
    final shadeColor =
        isShadeOfMain ? _shadeColor : (color[500] ?? color[400]!);

    setState(() {
      _mainColor = color;
      _shadeColor = shadeColor;
      _isMainSelection = false;
    });
    widget.onMainColorChange?.call(color);
    if (widget.onlyShadeSelection && !_isMainSelection) {
      return;
    }
    if (widget.allowShades) {
      widget.onColorChange?.call(shadeColor);
    }
  }

  void _onShadeColorSelected(Color color) {
    setState(() => _shadeColor = color);
    widget.onColorChange?.call(color);
  }

  void _onBack() {
    setState(() => _isMainSelection = true);
    widget.onBack?.call();
  }

  List<Widget> _buildListMainColor(List<ColorSwatch> colors) {
    return [
      for (final color in colors)
        CircleColor(
          color: color,
          circleSize: widget.circleSize,
          onColorChoose: (_) => _onMainColorSelected(color),
          isSelected: _mainColor == color,
          iconSelected: widget.iconSelected,
          elevation: widget.elevation,
        )
    ];
  }

  List<Color> _getMaterialColorShades(ColorSwatch color) {
    return <Color>[
      if (color[50] != null) color[50]!,
      if (color[100] != null) color[100]!,
      if (color[200] != null) color[200]!,
      if (color[300] != null) color[300]!,
      if (color[400] != null) color[400]!,
      if (color[500] != null) color[500]!,
      if (color[600] != null) color[600]!,
      if (color[700] != null) color[700]!,
      if (color[800] != null) color[800]!,
      if (color[900] != null) color[900]!,
    ];
  }

  List<Widget> _buildListShadesColor(ColorSwatch color) {
    return [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _onBack,
        padding: const EdgeInsets.only(right: 2.0),
      ),
      for (final color in _getMaterialColorShades(color))
        CircleColor(
          color: color,
          circleSize: widget.circleSize,
          onColorChoose: _onShadeColorSelected,
          isSelected: _shadeColor == color,
          iconSelected: widget.iconSelected,
          elevation: widget.elevation,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final listChildren = _isMainSelection || !widget.allowShades
        ? _buildListMainColor(_colors)
        : _buildListShadesColor(_mainColor);

    return SingleChildScrollView(
      physics: widget.physics,
      child: Wrap(
        alignment: widget.alignment,
        runAlignment: widget.runAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        runSpacing: widget.spacing,
        spacing: widget.spacing,
        children: listChildren,
      ),
    );
  }
}

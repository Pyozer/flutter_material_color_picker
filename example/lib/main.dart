import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material Color Picker",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  Color _shadeColor = Colors.blue[800];

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Main Color picker",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Material color picker",
            style: Theme.of(context).textTheme.headline,
          ),
          const SizedBox(height: 62.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: _mainColor,
                radius: 35.0,
                child: const Text("MAIN"),
              ),
              const SizedBox(width: 16.0),
              CircleAvatar(
                backgroundColor: _shadeColor,
                radius: 35.0,
                child: const Text("SHADE"),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          OutlineButton(
            onPressed: _openColorPicker,
            child: const Text('Show color picker'),
          ),
          const SizedBox(height: 16.0),
          OutlineButton(
            onPressed: _openMainColorPicker,
            child: const Text('Show main color picker'),
          ),
          const Text('(only main color)')
        ],
      ),
    );
  }
}

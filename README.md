# Flutter Material Color Picker [![pub package](https://img.shields.io/pub/v/flutter_material_color_picker.svg)](https://pub.dartlang.org/packages/flutter_material_color_picker)

Material Color picker is a Flutter widget, that can be customizable.

By default, it's Material Colors, but you can define your own colors.

You can also use CircleColor widget to display color in your app.
Example, you can set the color picker in a dialog and display the selected color in a ListTile, for settings.

## How to use it

These examples use a static color for 'selectedColor', but you can use a variable (state)

### Add to your Flutter project

You just need to add `flutter_material_color_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

```yaml
flutter_material_color_picker: ^0.0.6
```

### Import

```dart
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
```

### Basic

```dart
MaterialColorPicker(
    onColorChange: (Color color) {
        // Handle color changes
    },
    selectedColor: Colors.red
)
```

### Listen main color changes

```dart
MaterialColorPicker(
    onColorChange: (Color color) {
        // Handle color changes
    },
    onMainColorChange: (ColorSwatch color) {
        // Handle main color changes
    },
    selectedColor: Colors.red
)
```

### Disallow Shades

```dart
MaterialColorPicker(
    allowShades: false, // default true
    onMainColorChange: (ColorSwatch color) {
        // Handle main color changes
    },
    selectedColor: Colors.red
)
```
If `allowShades` is set to `false` then only main colors will be shown and allowed to be selected.
`onColorChange` will not be called, use `onMainColorChange` instead.

### Custom colors

In this example, custom colors are a list of Material Colors (class who extend of ColorSwatch).
But you can create your own list of ColorSwatch.

```dart
MaterialColorPicker(
    onColorChange: (Color color) {
        // Handle color changes
    },
    selectedColor: Colors.red,
    colors: [
        Colors.red,
        Colors.deepOrange,
        Colors.yellow,
        Colors.lightGreen
    ],
)
```

## Screenshot

### Color selection

There is two step, first choose the main color, and when you press it, you have to choose a shade of the main color.
By default it's all **Material Colors**, but you can define custom colors, a **list of ColorSwatch**.

<img title="Main color selection" src="https://github.com/Pyozer/color_picker/blob/master/demo/main_color.png?raw=true" width="400" />

<img title="Shade color selection" src="https://github.com/Pyozer/color_picker/blob/master/demo/shade_color.png?raw=true" width="400" />

### Example of usages

You can insert the color picker into a **Dialog**

<img title="Example main color in a dialog" src="https://github.com/Pyozer/color_picker/blob/master/demo/main_color_dialog.png?raw=true" width="400" />

<img title="Example shade color in a dialog" src="https://github.com/Pyozer/color_picker/blob/master/demo/shade_color_dialog.png?raw=true" width="400" />

### Display color

You can use CircleColor widget, to display the selected color into your settings for example.

<img title="Example of circlecolor widget in ListTile" src="https://github.com/Pyozer/color_picker/blob/master/demo/example_circle_color.png?raw=true" width="400" />

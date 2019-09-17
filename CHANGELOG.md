# CHANGELOG

## 1.0.5

* Fix issue with `elevation` property that cause crashes

## 1.0.4

* Add `physics` property ([See this PR](https://github.com/Pyozer/flutter_material_color_picker/pull/14))
* Add `elevation` property for circles ([See this PR](https://github.com/Pyozer/flutter_material_color_picker/pull/15))

## 1.0.3

* Add `onBack` callback to catch back button press ([See this issue](https://github.com/Pyozer/flutter_material_color_picker/issues/12))
* Fix color shade order mistake (Thanks to [@pczn0327](https://github.com/Pyozer/flutter_material_color_picker/pull/13))
* Code improvement

## 1.0.2

* Add `spacing` option, to define the minimum space between each color
* Add spacing value in the calculation to determine the number of color to display per line
* Remove padding added on shades by this [PR](https://github.com/Pyozer/flutter_material_color_picker/pull/9)
* **You should CHECK SIZE of colors, it could be changed with this update :/**

## 1.0.1

* Add `onlyShadeSelection` option, to have only shade changes callback (Thanks [@peyter213](https://github.com/Pyozer/flutter_material_color_picker/pull/10))
* Add predefined colors (accents and full material colors), since this [issue](https://github.com/Pyozer/flutter_material_color_picker/issues/8)
* Improve code and update example

## 1.0.0

* Code improvement
* Move to stable version 1.0.0

## 0.0.5

* Add `allowShades` property

## 0.0.4

* Fix icon on selected color
* Force icon's color (if light color set black icon, and if dark color set white icon)

## 0.0.3+1

* Edit README

## 0.0.3

* Improve design (use GridView)
* Add (customizable) icon on CircleColor when selected

## 0.0.2

* Add support of ColorSwatch and not MaterialColor
* Fix bug of colors null
* Fix bug if you just press main color, and not shade color, the change event not called
* Improve code

## 0.0.1

* Initial release

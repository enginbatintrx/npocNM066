import 'dart:ui';

extension ColorNames on Color {
  static const colorNames = {
    0xFFE1BEE7: 'Purple',
    0xFFC8E6C9: 'Green',
    0xFFB3E5FC: 'Blue',
    0xFFFFF9C4: 'Yellow',
    0xFFFFFFFF: 'White',
  };

  String colorName() => colorNames[value] ?? 'Undefined color';
}

extension toColor on String {
  toColorModule() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";

    if (hexColor.length == 8) return Color(int.parse("0x$hexColor"));
  }
}

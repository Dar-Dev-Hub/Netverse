import 'package:flutter/material.dart';

class TColor {
  static Color get primary => const Color.fromARGB(218, 172, 126, 0);
  static Color get title => const Color.fromARGB(218, 172, 126, 0);
  static Color get primaryText => const Color(0xff272422);
  static Color get secondaryText => const Color(0xff9D9EA3);
  static Color get white => Colors.white;
  static Color get balance => const Color.fromARGB(255, 83, 247, 140);
  static Color get daily => const Color.fromARGB(255, 80, 246, 255);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

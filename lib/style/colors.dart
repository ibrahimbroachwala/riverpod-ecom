import 'package:flutter/material.dart';

class AppColors {
  static Color yellow = '#FFD700'.hexToColor;
  static Color purple = '#8050CE'.hexToColor;
  static Color pink = '#ff70a6'.hexToColor;
  static Color maroon = '#a32638'.hexToColor;
  static Color lime = '#CDF871'.hexToColor;

  static Color primary = '#2D90B5'.hexToColor;
  static Color primaryDark = '#17475A'.hexToColor;
  static Color primaryLight = '#68CFF6'.hexToColor;

  static Color blue = '#70d6ff'.hexToColor;
  static Color ligthBlue = '#cce0ff'.hexToColor;
  static Color lightOrange = '#FFE3B6'.hexToColor;
  static Color lightYellow = '#FFF5C6'.hexToColor;
  static Color lightRed = '#FFC3C3'.hexToColor;
  static Color lightLime = '#E3FFA8'.hexToColor;

  static Color errorRed = '#FB3E3E'.hexToColor;
  static Color successGreen = '#50CE82'.hexToColor;

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color text = Color(0xff000000);
  static const Color lightGray = Color.fromARGB(255, 233, 233, 233);
  static const Color gray = Color.fromARGB(255, 186, 186, 186);
  static const Color darkerGray = Color.fromARGB(255, 130, 130, 130);
  static const Color labelColor = Color.fromARGB(255, 81, 81, 81);
  static const Color blackAlpha = Color(0xcc000000);
  static const Color whiteAlpha = Color(0xccffffff);
  static const Color gold = Color(0xffFFB302);

  static MaterialColor getMaterialColor(Color color) {
    final red = color.red;
    final green = color.green;
    final blue = color.blue;

    final shades = <int, Color>{
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}

extension StringExtension on String {
  Color get hexToColor => startsWith('#')
      ? Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000)
      : Color(int.parse(this, radix: 16) + 0xFF000000);
}

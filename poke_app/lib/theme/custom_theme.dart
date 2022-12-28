import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get portfolioTheme {
    return ThemeData(
      // primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ThemeData().colorScheme.copyWith(
          primary: Color(0xffDA1C27),
          // background: Color(0xff101010),
          background: Colors.white,
          secondary: Color(0xffDA1C27),
          secondaryContainer: Color(0xff961723),
          tertiary: Colors.grey[400],
          tertiaryContainer: Color(0xff1E1E1E)),
    );
  }
}

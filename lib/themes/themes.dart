import 'package:flutter/material.dart';

import 'colors_file.dart';

class ThemesProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  setDarkMode() {
    themeMode = ThemeMode.dark;
  }

  bool isDarkMode() => themeMode == ThemeMode.dark;
}

class MyTheme {

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: MyColors.white, fontSize: 34,),
      centerTitle: true,
      iconTheme: IconThemeData(
        size: 20,
      ),
    ),
    primaryColor: MyColors.darkBlue,
    colorScheme: const ColorScheme.light(
      secondary: MyColors.darkOrange,
      primaryVariant: MyColors.lightBlue,
    ),
    textTheme: TextTheme(
      headline3: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold), // btm nav bar titles
      headline4: const TextStyle(fontSize: 22, color: MyColors.lightBlack), // titles like (Create Room, Lasts, Room name, etc...)
      headline5: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100), // sub titles or cards description
      caption: const TextStyle(fontSize: 12, color: MyColors.lightBlack), // edit text caption
      subtitle1: TextStyle(fontSize: 16, color: MyColors.lightBlack.withOpacity(.29),),
    ),
  );

}
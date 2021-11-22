// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/themes.dart';
import 'package:kilo_bamya/ui/app_tour/view_page_provider.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/next_page_provider.dart';
import 'package:kilo_bamya/ui/home/btm_nav_provider.dart';
import 'package:kilo_bamya/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyViewPageProvider()),
        ChangeNotifierProvider(create: (_) => HomeClicksProvider()),
        ChangeNotifierProvider(create: (_) => NextPageProvider()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        darkTheme: MyTheme.lightTheme,
        theme: MyTheme.lightTheme,
        title: 'Kilo Bamya',
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
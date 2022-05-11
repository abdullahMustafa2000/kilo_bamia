// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kilo_bamya/themes/themes.dart';
import 'package:kilo_bamya/ui/app_tour/view_page_provider.dart';
import 'package:kilo_bamya/ui/home/teamSelection/teams_provider.dart';
import 'package:kilo_bamya/ui/home/btm_nav_provider.dart';
import 'package:kilo_bamya/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var localization = S();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyViewPageProvider()),
        ChangeNotifierProvider(create: (_) => HomeClicksProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
      ],
      child: MaterialApp(
        locale: const Locale(
          'en',
        ),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: ThemeMode.light,
        darkTheme: MyTheme.lightTheme,
        theme: MyTheme.lightTheme,
        title: localization.appName,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

S getString(BuildContext context) {
  return S.of(context);
}

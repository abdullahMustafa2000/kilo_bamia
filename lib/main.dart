// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kilo_bamya/classes/app_strings.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/themes/themes.dart';
import 'package:kilo_bamya/ui/home/btm_nav_provider.dart';
import 'package:kilo_bamya/ui/home/team_split/teams_provider.dart';
import 'package:kilo_bamya/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(GameModelAdapter());
  await Hive.openBox<GameModel>(ApplicationStrings.boxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeClicksProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
      ],
      child: MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        themeMode: ThemeMode.light,
        darkTheme: MyTheme.lightTheme,
        theme: MyTheme.lightTheme,
        onGenerateTitle: (context) {
          return getLocalization(context).appName;
        },
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

AppLocalizations getLocalization(BuildContext context) =>
    AppLocalizations.of(context)!;

Box<GameModel> teamsHiveDB() => Hive.box<GameModel>(ApplicationStrings.boxName);

bool isRTL(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl;

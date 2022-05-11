// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `kilobamyos`
  String get appName {
    return Intl.message(
      'kilobamyos',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descAppTourPage1 {
    return Intl.message(
      '',
      name: 'descAppTourPage1',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descAppTourPage2 {
    return Intl.message(
      '',
      name: 'descAppTourPage2',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descAppTourPage3 {
    return Intl.message(
      '',
      name: 'descAppTourPage3',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnNextAppTour {
    return Intl.message(
      '',
      name: 'btnNextAppTour',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnDoneAppTour {
    return Intl.message(
      '',
      name: 'btnDoneAppTour',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnCreateGame {
    return Intl.message(
      '',
      name: 'btnCreateGame',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnCreateRoom {
    return Intl.message(
      '',
      name: 'btnCreateRoom',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnSpin {
    return Intl.message(
      '',
      name: 'btnSpin',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnSpinAgain {
    return Intl.message(
      '',
      name: 'btnSpinAgain',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnSave {
    return Intl.message(
      '',
      name: 'btnSave',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleRecent {
    return Intl.message(
      '',
      name: 'titleRecent',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descRecentPlayer {
    return Intl.message(
      '',
      name: 'descRecentPlayer',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descRecentTeam {
    return Intl.message(
      '',
      name: 'descRecentTeam',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleLabelRoomName {
    return Intl.message(
      '',
      name: 'titleLabelRoomName',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleLabelResult {
    return Intl.message(
      '',
      name: 'titleLabelResult',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleLabelEnterNoTeams {
    return Intl.message(
      '',
      name: 'titleLabelEnterNoTeams',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleLabelEnterNoPlayers {
    return Intl.message(
      '',
      name: 'titleLabelEnterNoPlayers',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleLabelEnterPlayersNames {
    return Intl.message(
      '',
      name: 'titleLabelEnterPlayersNames',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get hintEnterName {
    return Intl.message(
      '',
      name: 'hintEnterName',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get numOf {
    return Intl.message(
      '',
      name: 'numOf',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get toastFillFieldsError {
    return Intl.message(
      '',
      name: 'toastFillFieldsError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleBtmNavWheel {
    return Intl.message(
      '',
      name: 'titleBtmNavWheel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleBtmNavCoin {
    return Intl.message(
      '',
      name: 'titleBtmNavCoin',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get btnThrowCoin {
    return Intl.message(
      '',
      name: 'btnThrowCoin',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleAbout {
    return Intl.message(
      '',
      name: 'titleAbout',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get titleOtherApps {
    return Intl.message(
      '',
      name: 'titleOtherApps',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get descAbout {
    return Intl.message(
      '',
      name: 'descAbout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

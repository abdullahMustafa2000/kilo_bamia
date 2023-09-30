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

  /// `Kilo Bamia`
  String get appName {
    return Intl.message(
      'Kilo Bamia',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Let's Split`
  String get btnCreateRoom {
    return Intl.message(
      'Let\'s Split',
      name: 'btnCreateRoom',
      desc: '',
      args: [],
    );
  }

  /// `Confused between what?`
  String get enterChoicesNames {
    return Intl.message(
      'Confused between what?',
      name: 'enterChoicesNames',
      desc: '',
      args: [],
    );
  }

  /// `Recent Splits`
  String get recentListTitle {
    return Intl.message(
      'Recent Splits',
      name: 'recentListTitle',
      desc: '',
      args: [],
    );
  }

  /// `The most 2 recent Splits will appear here.`
  String get emptyListMessage {
    return Intl.message(
      'The most 2 recent Splits will appear here.',
      name: 'emptyListMessage',
      desc: '',
      args: [],
    );
  }

  /// `Wheel`
  String get wheelTabName {
    return Intl.message(
      'Wheel',
      name: 'wheelTabName',
      desc: '',
      args: [],
    );
  }

  /// `Coin`
  String get coinTabName {
    return Intl.message(
      'Coin',
      name: 'coinTabName',
      desc: '',
      args: [],
    );
  }

  /// `Flip`
  String get throwCoin {
    return Intl.message(
      'Flip',
      name: 'throwCoin',
      desc: '',
      args: [],
    );
  }

  /// `Name it :`
  String get nameTheSplit {
    return Intl.message(
      'Name it :',
      name: 'nameTheSplit',
      desc: '',
      args: [],
    );
  }

  /// `Ex: PlayStation`
  String get splitNameHint {
    return Intl.message(
      'Ex: PlayStation',
      name: 'splitNameHint',
      desc: '',
      args: [],
    );
  }

  /// `People :`
  String get numberOfParticipants {
    return Intl.message(
      'People :',
      name: 'numberOfParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Teams :`
  String get numberOfTeams {
    return Intl.message(
      'Teams :',
      name: 'numberOfTeams',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get createSplit {
    return Intl.message(
      'Next',
      name: 'createSplit',
      desc: '',
      args: [],
    );
  }

  /// `Enter People :`
  String get enterPeople {
    return Intl.message(
      'Enter People :',
      name: 'enterPeople',
      desc: '',
      args: [],
    );
  }

  /// `Split`
  String get splitPeopleBtn {
    return Intl.message(
      'Split',
      name: 'splitPeopleBtn',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get splitResult {
    return Intl.message(
      'Result',
      name: 'splitResult',
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

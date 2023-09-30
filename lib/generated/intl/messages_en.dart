// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Kilo Bamia"),
        "btnCreateRoom": MessageLookupByLibrary.simpleMessage("Let\'s Split"),
        "coinTabName": MessageLookupByLibrary.simpleMessage("Coin"),
        "createSplit": MessageLookupByLibrary.simpleMessage("Next"),
        "emptyListMessage": MessageLookupByLibrary.simpleMessage(
            "The most 2 recent Splits will appear here."),
        "enterChoicesNames":
            MessageLookupByLibrary.simpleMessage("Confused between what?"),
        "enterPeople": MessageLookupByLibrary.simpleMessage("Enter People :"),
        "nameTheSplit": MessageLookupByLibrary.simpleMessage("Name it :"),
        "numberOfParticipants":
            MessageLookupByLibrary.simpleMessage("People :"),
        "numberOfTeams": MessageLookupByLibrary.simpleMessage("Teams :"),
        "recentListTitle":
            MessageLookupByLibrary.simpleMessage("Recent Splits"),
        "splitNameHint":
            MessageLookupByLibrary.simpleMessage("Ex: PlayStation"),
        "splitPeopleBtn": MessageLookupByLibrary.simpleMessage("Split"),
        "splitResult": MessageLookupByLibrary.simpleMessage("Result"),
        "throwCoin": MessageLookupByLibrary.simpleMessage("Flip"),
        "wheelTabName": MessageLookupByLibrary.simpleMessage("Wheel")
      };
}

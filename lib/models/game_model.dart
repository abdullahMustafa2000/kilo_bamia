import 'package:kilo_bamya/local_db/shared_pref.dart';

class GameModel {
  String? id;
  String? roomName;
  int? noOfPlayers;
  int? noOfTeams;
  List<String>? result;
  DateTime? time;

  GameModel(
      {required this.id,
      required this.roomName,
      required this.noOfPlayers,
      required this.noOfTeams,
      required this.result,
      required this.time});

  GameModel.init() {
    roomName = '';
    noOfPlayers = 0;
    noOfTeams = 0;
    result = [];
    time = DateTime.now();
  }

  GameModel copy(
          {id, roomName, noOfPlayers, noOfTeams, players, result, time}) =>
      GameModel(
          id: id ?? this.id,
          roomName: roomName ?? this.roomName,
          noOfPlayers: noOfPlayers ?? this.noOfPlayers,
          noOfTeams: noOfTeams ?? this.noOfTeams,
          result: result ?? this.result,
          time: time ?? this.time);

  Map<String, Object?> toJson() {
    return {
      GameTable.id: id,
      GameTable.roomName: roomName,
      GameTable.noOfPlayers: noOfPlayers,
      GameTable.noOfTeams: noOfTeams,
      GameTable.result: result,
      GameTable.time: time!.toIso8601String(),
    };
  }

  static GameModel fromJson(Map<Object?, Object?> json) {
    return GameModel(
        id: json[GameTable.id] as String?,
        roomName: json[GameTable.roomName] as String?,
        noOfPlayers: json[GameTable.noOfPlayers] as int?,
        noOfTeams: json[GameTable.noOfTeams] as int?,
        result: json[GameTable.result] as List<String>?,
        time: DateTime.parse(json[GameTable.time] as String));
  }
}

class GameTable {
  static const tableName = 'game_table';
  static const values = [
    id,
    roomName,
    noOfPlayers,
    noOfTeams,
    players,
    result,
    time
  ];

  static const id = '_id';
  static const roomName = 'roomName';
  static const noOfPlayers = 'noOfPlayers';
  static const noOfTeams = 'noOfTeams';
  static const players = 'players';
  static const result = 'result';
  static const time = 'time';
}

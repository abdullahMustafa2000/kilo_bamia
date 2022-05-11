class GameModel {
  int? id;
  String? roomName;
  int? noOfPlayers;
  int? noOfTeams;
  List<String>? players;
  List<String>? result;
  DateTime? time;

  GameModel(
      {required this.id,
      required this.roomName,
      required this.noOfPlayers,
      required this.noOfTeams,
      required this.players,
      required this.result,
      required this.time});

  GameModel.init() {
    roomName = '';
    noOfPlayers = 0;
    noOfTeams = 0;
    players = [];
    result = [];
    time = DateTime.now();
  }

  static String convertListToString(List<String> list) {
    String result = '';
    for (var i = 0; i < list.length; i++) {
      String item = list[i];
      if (i != list.length - 1) {
        item += '?';
      }
      result += item;
    }
    return result;
  }

  static List<String> convertStringToList(String result) => result.split('?');

  GameModel copy(
          {id, roomName, noOfPlayers, noOfTeams, players, result, time}) =>
      GameModel(
          id: id ?? this.id,
          roomName: roomName ?? this.roomName,
          noOfPlayers: noOfPlayers ?? this.noOfPlayers,
          noOfTeams: noOfTeams ?? this.noOfTeams,
          players: players ?? this.players,
          result: result ?? this.result,
          time: time ?? this.time);

  Map<String, Object?> toJson() {
    return {
      GameTable.roomName: roomName,
      GameTable.noOfPlayers: noOfPlayers,
      GameTable.noOfTeams: noOfTeams,
      GameTable.players: convertListToString(players!),
      GameTable.result: convertListToString(result!),
      GameTable.time: time!.toIso8601String(),
    };
  }

  static GameModel fromJson(Map<String, Object?> json) {
    return GameModel(
        id: json[GameTable.id] as int?,
        roomName: json[GameTable.roomName] as String,
        noOfPlayers: json[GameTable.noOfPlayers] as int,
        noOfTeams: json[GameTable.noOfTeams] as int,
        players: convertStringToList(json[GameTable.players] as String),
        result: convertStringToList(json[GameTable.result] as String),
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

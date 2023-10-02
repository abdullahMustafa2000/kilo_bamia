class GameModel {
  String? id;
  String? roomName;
  int? noOfPlayers;
  int? noOfTeams;
  List<String> players = [];
  List<String> teams = [];
  DateTime? time;

  GameModel(
      {required this.roomName,
      required this.noOfPlayers,
      required this.noOfTeams,
      required this.players,
      required this.time,
      required this.teams,
      this.id});

  GameModel.init() {
    roomName = '';
    noOfPlayers = 0;
    noOfTeams = 0;
    players = [];
    teams = [];
    time = DateTime.now();
  }

  GameModel copy(
          {id, roomName, noOfPlayers, noOfTeams, players, result, time}) =>
      GameModel(
          id: id,
          roomName: roomName ?? this.roomName,
          noOfPlayers: noOfPlayers ?? this.noOfPlayers,
          noOfTeams: noOfTeams ?? this.noOfTeams,
          players: result ?? this.players,
          teams: teams,
          time: time ?? this.time);

  Map<String, Object?> toJson() {
    return {
      GameTable.id: id,
      GameTable.roomName: roomName,
      GameTable.noOfPlayers: noOfPlayers,
      GameTable.noOfTeams: noOfTeams,
      GameTable.players: players,
      GameTable.teams: teams,
      GameTable.time: time!.toIso8601String(),
    };
  }

  static GameModel fromJson(Map<Object?, Object?> json) {
    return GameModel(
        id: json[GameTable.id] as String?,
        roomName: json[GameTable.roomName] as String?,
        noOfPlayers: json[GameTable.noOfPlayers] as int?,
        noOfTeams: json[GameTable.noOfTeams] as int?,
        players: listFromObject(json[GameTable.players] as List<Object?>),
        teams: listFromObject(json[GameTable.teams] as List<Object?>),
        time: DateTime.parse(json[GameTable.time] as String));
  }

  static List<String> listFromObject(List<Object?> list) {
    List<String> result = [];
    for (var element in list) {
      result.add(element as String);
    }
    return result;
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
    teams,
    time
  ];

  static const id = '_id';
  static const roomName = 'roomName';
  static const noOfPlayers = 'noOfPlayers';
  static const noOfTeams = 'noOfTeams';
  static const players = 'players';
  static const teams = 'result';
  static const time = 'time';
}

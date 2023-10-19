import 'package:hive/hive.dart';
part 'game_model.g.dart';
@HiveType(typeId: 1)
class GameModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String roomName = '';
  @HiveField(2)
  int noOfPlayers = 0;
  @HiveField(3)
  int noOfTeams = 0;
  @HiveField(4)
  List<String> players = [];
  @HiveField(5)
  List<String> teams = [];
  @HiveField(6)
  DateTime time = DateTime.now();
  bool? firstSplit;

  GameModel(
      {required this.roomName,
      required this.noOfPlayers,
      required this.noOfTeams,
      required this.players,
      required this.time,
      required this.teams,
      this.id, this.firstSplit = true});

  GameModel.init() {
    roomName = '';
    noOfPlayers = 0;
    noOfTeams = 0;
    players = [];
    teams = [];
    time = DateTime.now();
    firstSplit = true;
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
        roomName: json[GameTable.roomName] as String,
        noOfPlayers: json[GameTable.noOfPlayers] as int,
        noOfTeams: json[GameTable.noOfTeams] as int,
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

// class GameModelAdapter extends TypeAdapter<GameModel> {
//   @override
//   final typeId = 0;
//
//   @override
//   GameModel read(BinaryReader reader) {
//     return GameModel(
//         roomName: reader.readString(),
//         noOfPlayers: reader.readInt(),
//         noOfTeams: reader.readInt(),
//         players: reader.readStringList(),
//         teams: reader.readStringList(),
//         time: reader.read());
//   }
//
//   @override
//   void write(BinaryWriter writer, GameModel obj) {
//     writer.writeString(obj.roomName);
//     writer.writeInt(obj.noOfPlayers);
//     writer.writeInt(obj.noOfTeams);
//     writer.writeStringList(obj.players);
//     writer.writeStringList(obj.teams);
//     writer.write<DateTime>(obj.time);
//   }
// }

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

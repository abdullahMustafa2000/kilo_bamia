// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameModelAdapter extends TypeAdapter<GameModel> {
  @override
  final int typeId = 1;

  @override
  GameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModel(
      roomName: fields[1] as String,
      noOfPlayers: fields[2] as int,
      noOfTeams: fields[3] as int,
      players: (fields[4] as List).cast<String>(),
      time: fields[6] as DateTime,
      teams: (fields[5] as List).cast<String>(),
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomName)
      ..writeByte(2)
      ..write(obj.noOfPlayers)
      ..writeByte(3)
      ..write(obj.noOfTeams)
      ..writeByte(4)
      ..write(obj.players)
      ..writeByte(5)
      ..write(obj.teams)
      ..writeByte(6)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

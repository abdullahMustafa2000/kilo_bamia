class RoomModule {
  String roomName;
  int numberOfPlayers;
  int numberOFTeams;
  DateTime createDate;
  Map<String, List<String>>? teams;

  RoomModule(
      {required this.roomName,
      required this.numberOfPlayers,
      required this.numberOFTeams,
      required this.createDate,
      this.teams});
}
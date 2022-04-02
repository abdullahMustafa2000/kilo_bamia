
class RoomModule {
  String roomName;
  int numberOfPlayers;
  int numberOFTeams;
  String createDate;
  List<String>? teams;

  RoomModule(
      {required this.roomName,
      required this.numberOfPlayers,
      required this.numberOFTeams,
      required this.createDate,
      this.teams});

  static const String room_name_prefKey = "RoomName";
  static const String num_of_players_prefKey = "RoomPlayers";
  static const String num_of_teams_prefKey = "RoomTeams";
  static const String create_date_prefKey = "RoomDate";
  static const String room_teams_list_prefKey = "RoomTeamsDivide";
  static const String room_players_names_prefKey = "RoomPlayersNames";
}
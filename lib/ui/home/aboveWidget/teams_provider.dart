import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:kilo_bamya/shared_pereferences/saved_game.dart';

class TeamProvider extends ChangeNotifier {
  late List<String> teams;
  late List<String> players;
  late int noOfTeams;
  TeamProvider() {
    teams = [];
    noOfTeams = -1;
  }

  void dividePlayers() async {
    teams = [];
    int noOfPlayers = players.length;
    List<int> list = teamCount(noOfPlayers, noOfTeams);
    int noOfPlayersEachTeam = list[0];
    List<String> playersList = List.filled(list[1], '');
    playersList = players;
    List<bool> alreadySelected = List.filled(playersList.length, false);
    for (var i = 0; i < noOfTeams; i++) {
      String team = '';
      int counter = 1;
      do {
        int randomNumber = Random().nextInt(playersList.length);

        if (!alreadySelected[randomNumber]) {
          team += '${playersList[randomNumber]},';
          alreadySelected[randomNumber] = true;
          counter++;
        }
      } while (counter <= noOfPlayersEachTeam);
      teams.add(team);
    }
    notifyListeners();
    StorageManager.saveData(RoomModule.room_teams_list_prefKey, teams);
  }

  List<int> teamCount(int noOfPlayers, int numberOfTeams) {
    if (noOfPlayers % numberOfTeams != 0) {
      do {
        noOfPlayers++;
      } while (noOfPlayers % numberOfTeams != 0);
    }
    return [noOfPlayers ~/ numberOfTeams, noOfPlayers];
  }

}
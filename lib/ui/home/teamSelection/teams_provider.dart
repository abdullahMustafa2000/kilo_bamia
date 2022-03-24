import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:kilo_bamya/shared_pereferences/saved_game.dart';

class TeamProvider extends ChangeNotifier {
  late List<String> teams;

  late List<String> players;

  late int noOfPlayers;

  late int noOfTeams;

  late String roomName;

  bool divided = false;

  TeamProvider() {
    teams = [];
    noOfTeams = -1;
    noOfPlayers = -1;
    roomName = '';
  }

  List<String> dividePlayers() {
    teams = List.filled(noOfTeams, '');
    int noOfPlayers = players.length; //5
                                            //2
    List<int> list = teamCount(noOfPlayers, noOfTeams);
    int noOfPlayersEachTeam = list[0]; //3
    for (var i = 0; i < noOfPlayers;) {
      var randomNum = Random().nextInt(noOfTeams);
      String team = teams[randomNum];
      if(!checkNumOfPlayersFrom(team, noOfPlayersEachTeam)) {
        teams[randomNum]+='${players[i]},';
        i++;
      }
    }
    notifyListeners();
    StorageManager.saveData(RoomModule.room_teams_list_prefKey, teams);
    return teams;
  }

  List<int> teamCount(int noOfPlayers, int numberOfTeams) {
    if (noOfPlayers % numberOfTeams != 0) {
      do {
        noOfPlayers++;
      } while (noOfPlayers % numberOfTeams != 0);
    }
    return [noOfPlayers ~/ numberOfTeams, noOfPlayers];
  }

  void newTeamDivided() {
    divided = true;
    notifyListeners();
  }

  bool checkNumOfPlayersFrom(String team, int noOfPlayersEachTeam) {
    return team.split(',').length-1 == noOfPlayersEachTeam;
  }
}

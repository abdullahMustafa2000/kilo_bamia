import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kilo_bamya/models/game_model.dart';

class TeamProvider {

  static List<String> splitPlayers(GameModel gameModel) {
    int noOfPlayers = gameModel.noOfPlayers ?? 0;
    int noOfTeams = gameModel.noOfTeams ?? 0;
    List<String> teams = List.filled(noOfTeams, '');
    List<int> list = teamCount(noOfPlayers, noOfTeams);
    int noOfPlayersEachTeam = list[0];
    for (var i = 0; i < noOfPlayers;) {
      var randomNum = Random().nextInt(noOfTeams);
      String team = teams[randomNum];
      if(!checkNumOfPlayersFrom(team, noOfPlayersEachTeam)) {
        teams[randomNum] += '${gameModel.players[i]},';
        i++;
      }
    }
    return teams;
  }

  static List<int> teamCount(int noOfPlayers, int numberOfTeams) {
    if (noOfPlayers % numberOfTeams != 0) {
      do {
        noOfPlayers++;
      } while (noOfPlayers % numberOfTeams != 0);
    }
    return [noOfPlayers ~/ numberOfTeams, noOfPlayers];
  }

  static bool checkNumOfPlayersFrom(String team, int noOfPlayersEachTeam) {
    return team.split(',').length-1 == noOfPlayersEachTeam;
  }
}

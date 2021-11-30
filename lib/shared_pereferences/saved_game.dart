import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<List> initPreferences() async {
    List values = [];
    final prefs = await SharedPreferences.getInstance();
    //room name 0
    values[0] = prefs.getString(RoomModule.room_name_prefKey);
    // number of players 1
    values[1] = prefs.getInt(RoomModule.num_of_players_prefKey);
    // number of teams 2
    values[2] = prefs.getInt(RoomModule.num_of_teams_prefKey);
    // create date 3
    values[3] = prefs.getString(RoomModule.create_date_prefKey);
    // team divide 4
    values[4] = prefs.getStringList(RoomModule.room_teams_list_prefKey);
    // players names 5
    values[5] = prefs.getStringList(RoomModule.room_players_names_prefKey);
    return values;
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
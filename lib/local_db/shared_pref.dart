import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  static const String roomId = "roomId";
  static Future<String> getNewRoomId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt(roomId);
    if (id == null) {
      preferences.setInt(roomId, 1);
      id = 1;
    } else {
      preferences.setInt(roomId, ++id);
    }
    return id.toString();
  }
}
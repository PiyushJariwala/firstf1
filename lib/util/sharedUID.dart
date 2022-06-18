import 'package:shared_preferences/shared_preferences.dart';

void CreatShaerID(String uid) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("uid", uid);
}

Future<String?> GetUidData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("uid");
}

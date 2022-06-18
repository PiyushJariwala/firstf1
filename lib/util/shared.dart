import 'package:shared_preferences/shared_preferences.dart';

void getShareData(bool isShow) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("show", isShow);
}

void setShareData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.getBool("show");
}

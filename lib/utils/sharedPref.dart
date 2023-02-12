import 'package:shared_preferences/shared_preferences.dart';

void saveText(String key, String value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(key, value);
}


readText(String key)  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var value = preferences.getString(key) ?? "00";
  return value;
}



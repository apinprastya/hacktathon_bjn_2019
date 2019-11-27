import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static const String USER = 'User';
  static SharedPreferences pref;
  static init() async {
    pref = await SharedPreferences.getInstance();
  }
}

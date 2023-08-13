import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static final Globals _globals = Globals._internal();
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static bool easyAccess = false;

  factory Globals() {
    return _globals;
  }

  static Future<void> loadDataFromPref() async {
    final SharedPreferences prefs = await _prefs;
    final bool? ezAccess = prefs.getBool('ezAccess');
    if (ezAccess == null) {
      easyAccess = false;
    } else {
      easyAccess = ezAccess;
    }
  }

  static Future<void> setEasyAccess(bool easyAccess) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('ezAccess', easyAccess);
    Globals.easyAccess = easyAccess;
  }

  Globals._internal();
}

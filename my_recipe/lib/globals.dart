import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static final Globals _globals = Globals._internal();
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static bool easyAccess = false;
  static bool hapticFeedback = false;

  factory Globals() {
    return _globals;
  }

  static Future<void> loadDataFromPref() async {
    final SharedPreferences prefs = await _prefs;
    final bool? ezAccess = prefs.getBool('ezAccess');
    final bool? htFeedback = prefs.getBool('htFeedback');

    if (ezAccess == null) {
      easyAccess = false;
    } else {
      easyAccess = ezAccess;
    }

    if (htFeedback == null) {
      hapticFeedback = false;
    } else {
      hapticFeedback = htFeedback;
    }
  }

  static Future<void> setEasyAccess(bool easyAccess) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('ezAccess', easyAccess);
    Globals.easyAccess = easyAccess;
  }

  static Future<void> setHapticFeedback(bool hapticFeedback) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('htFeedback', hapticFeedback);
    Globals.hapticFeedback = hapticFeedback;
  }

  Globals._internal();
}

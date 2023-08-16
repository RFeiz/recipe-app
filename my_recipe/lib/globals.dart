import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static final Globals _globals = Globals._internal();
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static bool easyAccess = false;
  static bool hapticFeedback = false;

  // ignore: unused_field
  static double speechPitch = 1.0;
  // ignore: unused_field
  static double speechSpeed = 1.0;

  factory Globals() {
    return _globals;
  }

  static Future<void> loadDataFromPref() async {
    final SharedPreferences prefs = await _prefs;

    final bool? ezAccess = prefs.getBool('ezAccess');
    final bool? htFeedback = prefs.getBool('htFeedback');

    final double? ttsPitch = prefs.getDouble('ttsPitch');
    final double? ttsSpeed = prefs.getDouble('ttsSpeed');

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

    if (ttsPitch == null) {
      speechPitch = 1.0;
    } else {
      speechPitch = ttsPitch;
    }

    if (ttsSpeed == null) {
      speechSpeed = 1.0;
    } else {
      speechSpeed = ttsSpeed;
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

  static Future<void> setSpeechPitch(double value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('ttsPitch', value);
    Globals.speechPitch = value;
  }

  static Future<void> setSpeechSpeed(double value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('ttsSpeed', value);
    Globals.speechSpeed = value;
  }

  Globals._internal();
}

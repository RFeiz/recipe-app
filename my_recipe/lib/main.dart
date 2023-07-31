import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_recipe/login/loginPage.dart';
import 'package:my_recipe/models/custom_query.dart';
import 'package:my_recipe/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  ThemeMode currentThemeMode = ThemeMode.system;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // CustomQuery query = CustomQuery();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<ThemeMode> _getThemeMode() async {
    final SharedPreferences prefs = await _prefs;
    final int? themeMode = prefs.getInt('themeMode');
    if (themeMode == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[themeMode];
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('themeMode', mode.index);
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      widget.currentThemeMode = mode;
      _setThemeMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getThemeMode().then((ThemeMode mode) {
      setState(() {
        widget.currentThemeMode = mode;
      });
    });

    // query.wait();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyRecipes',
          themeMode: widget.currentThemeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: lightDynamic?.primary ?? Colors.green,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: darkDynamic?.primary ?? Colors.green,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          // Determine the initial route based on authentication state
          initialRoute:
              FirebaseAuth.instance.currentUser == null ? '/login' : '/main',
          routes: {
            '/login': (context) => const LoginPage(),
            '/main': (context) => MainView(
                onThemeChanged: (ThemeMode mode) => setThemeMode(mode)),
          },
        );
      },
    );
  }
}

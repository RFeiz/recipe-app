import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/login/loginPage.dart';

import 'package:my_recipe/models/custom_query.dart';
import 'package:my_recipe/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomQuery query = CustomQuery();
    query.wait();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Recipes',
          themeMode: ThemeMode.system,
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
            '/main': (context) => const MainView(),
          },
        );
      },
    );
  }
}

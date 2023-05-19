import 'package:flutter/material.dart';
import 'package:my_recipe/home/home.dart';
import 'package:my_recipe/widgets/customNavigationBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Recipes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1FCC79)),
          useMaterial3: true,
        ),
        home: SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.search),
              ),
              body: Home(),
              bottomNavigationBar: CustomNavigationBar()),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:my_recipe/favourites/favourites.dart';
import 'package:my_recipe/home/home.dart';
import 'package:my_recipe/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Recipes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 186, 31, 243)),
          useMaterial3: true,
        ),
        home: SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.search),
              ),
              body: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                children: const [Home(), Favourites(), Profile()],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  pageController.animateToPage(value,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.ease);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border_outlined),
                      label: "Favourites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline), label: "Profile"),
                ],
                currentIndex: currentIndex,
              )),
        ));
  }
}
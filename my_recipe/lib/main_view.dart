import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/favourites/favouriteList/widgets/favourite_card.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/profile/profile.dart';
import 'package:search_page/search_page.dart';

import 'favourites/favourites.dart';
import 'home/home.dart';

class MainView extends StatefulWidget {
  MainView({super.key, required this.onThemeChanged});

  final Function(ThemeMode) onThemeChanged;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 1;
  PageController pageController = PageController(initialPage: 1);
  List<Food> foodList = [];

  Future getFoodList() async {
    // ordered by like and get the top 10
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('likes', descending: true)
        .limit(10)
        .get();

    final List<dynamic> foodData = querySnapshot.docs
        .map((QueryDocumentSnapshot<dynamic> doc) => doc.data())
        .toList();

    foodList.clear();
    for (var element in foodData) {
      Food food = Food.convertToFood(element);
      foodList.add(food);
    }
  }

  @override
  Widget build(BuildContext context) {
    getFoodList();
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () => showSearch(
                    context: context,
                    delegate: SearchPage<Food>(
                      items: foodList,
                      searchLabel: 'Search Recipe',
                      suggestion: const Center(
                        child: Text('Search Recipe by Name'),
                      ),
                      failure: const Center(
                        child: Text('No Recipe found'),
                      ),
                      filter: (food) => [food.name],
                      builder: (food) => FavouriteCard(
                        food: food,
                        updateList: (value) {},
                      ),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          children: [
            const Favourites(),
            const Home(),
            Profile(
              onThemeChanged: (ThemeMode mode) => widget.onThemeChanged(mode),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (value) {
            setState(() {
              currentIndex = value;
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: "Favourites"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
          currentIndex: currentIndex,
        ));
  }
}

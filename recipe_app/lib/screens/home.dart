import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/foodCard.dart';
import 'package:recipe_app/widgets/foodListView.dart';

import 'package:recipe_app/dataStructures/foodStructure.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Food pizza = Food(
      name: "Pizza",
      description: "Italian",
      image:
          "https://firebasestorage.googleapis.com/v0/b/recipe-app-6d61d.appspot.com/o/pizza.jpeg?alt=media&token=2dd5e22d-132f-4733-9fb4-b935bbfc2e93",
      calories: 250,
      isFavorite: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, User2213"),
            Text("what are you cooking today?"),
            SizedBox(height: 20),
            FoodListView(),
            SizedBox(height: 50),
            Text("Trending Dinner"),
            FoodCard(
              food: pizza,
              width: MediaQuery.of(context).size.width,
              height: 250,
            )
          ],
        ),
      ),
    );
  }
}

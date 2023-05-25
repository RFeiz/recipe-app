// popular_list.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/home/popularSelection/widgets/popular_card.dart';
import 'package:my_recipe/models/ingredient.dart';

import 'widgets/popular_card_skeleton.dart';

class PopularList extends StatefulWidget {
  PopularList({Key? key}) : super(key: key);

  final List<Food> popularFoodList = [
    Food(
      name: "Pasta with Tomato Sauce",
      smallDescription:
          "A delicious pasta with tomato sauce and cheese topping.",
      longDescription:
          "A delicious pasta with tomato sauce and cheese topping.",
      thumbnailUrl:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
      cookingTime: "30m",
      calories: 596,
      likes: 5,
      ingredientList: [
        Ingredient(name: "Pasta", quantity: "200", unit: "g"),
        Ingredient(name: "Tomato", quantity: "2", unit: "pcs"),
        Ingredient(name: "Cheese", quantity: "100", unit: "g"),
      ],
    ),
    Food(
      name: "Beef Wellington",
      smallDescription:
          "Beef tenderloin wrapped in layers of pâté, duxelles, parma ham, and puff pastry, then baked.",
      longDescription: "Beef with a crust of puff pastry.",
      thumbnailUrl:
          "https://images.unsplash.com/photo-1675718341348-65224936b742?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1115&q=80",
      cookingTime: "4h",
      calories: 427,
      likes: 256302,
      ingredientList: [
        Ingredient(name: "Beef", quantity: "1", unit: "kg"),
        Ingredient(name: "Puff Pastry", quantity: "200", unit: "g"),
        Ingredient(name: "Mushroom", quantity: "100", unit: "g"),
      ],
    ),
    Food(
      name: "Ramen Noodles",
      smallDescription:
          "A Chinese noodle dish with a fish-based broth and a variety of toppings.",
      longDescription:
          "A Chinese noodle dish with a fish-based broth and a variety of toppings.",
      thumbnailUrl:
          "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
      cookingTime: "15m",
      calories: 450,
      likes: 785000000,
      ingredientList: [
        Ingredient(name: "Noodles", quantity: "200", unit: "g"),
        Ingredient(name: "Fish", quantity: "100", unit: "g"),
        Ingredient(name: "Mushroom", quantity: "100", unit: "g"),
      ],
    ),
  ];

  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  int _index = 0;
  List<Food> foodList = [];

  // get and retuen the popular food list
  Future getFoodList() async {
    foodList.clear();
    await FirebaseFirestore.instance
        .collection('recipes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Food food = Food(
          name: doc['name'],
          smallDescription: doc['small_description'],
          longDescription: doc['long_description'],
          thumbnailUrl: doc['thumbnail_url'],
          cookingTime: doc['cooking_time'],
          calories: doc['calories'],
          likes: doc['likes'],
          ingredientList: [],
        );
        foodList.add(food);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10),
      child: FutureBuilder(
        future: getFoodList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PageView.builder(
              itemCount: foodList.length,
              controller: PageController(viewportFraction: 0.82),
              itemBuilder: (_, i) {
                return PopularCard(food: foodList[i]);
              },
            );
          } else {
            return PageView.builder(
              itemCount: 1,
              controller: PageController(viewportFraction: 0.82),
              itemBuilder: (_, i) {
                return PopularCardSkeleton();
              },
            );
          }
        },
      ),
    );
  }
}

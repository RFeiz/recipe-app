import 'package:flutter/material.dart';
import 'package:recipe_app/dataStructures/foodStructure.dart';
import 'foodCard.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({Key? key}) : super(key: key);

  @override
  _FoodListViewState createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  Food pizza = Food(
      name: "Pizza",
      description: "Italian",
      image:
          "https://firebasestorage.googleapis.com/v0/b/recipe-app-6d61d.appspot.com/o/pizza.jpeg?alt=media&token=2dd5e22d-132f-4733-9fb4-b935bbfc2e93",
      calories: 250,
      isFavorite: false);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 260,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            FoodCard(
              food: pizza,
              width: 200,
              height: 200,
            ),
            FoodCard(
              food: pizza,
              width: 200,
              height: 200,
            ),
            FoodCard(
              food: pizza,
              width: 200,
              height: 200,
            ),
            FoodCard(
              food: pizza,
              width: 200,
              height: 200,
            ),
            FoodCard(
              food: pizza,
              width: 200,
              height: 200,
            )
          ],
        ));
  }
}

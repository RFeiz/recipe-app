import 'package:flutter/material.dart';

import 'foodCard.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({Key? key}) : super(key: key);

  @override
  _FoodListViewState createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 260,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            FoodCard(),
            FoodCard(),
            FoodCard(),
            FoodCard(),
            FoodCard()
          ],
        ));
  }
}

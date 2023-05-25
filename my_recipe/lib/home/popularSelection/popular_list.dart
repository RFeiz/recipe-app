// popular_list.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/home/popularSelection/widgets/popular_card.dart';

import 'widgets/popular_card_skeleton.dart';

class PopularList extends StatefulWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  List<Food> foodList = [];

  // get and retuen the popular food list
  Future getFoodList() async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      foodList.clear();
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
                return const PopularCardSkeleton();
              },
            );
          }
        },
      ),
    );
  }
}

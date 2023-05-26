import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/favourites/favouriteList/widgets/favourite_card.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/user.dart';

class FavouriteList extends StatefulWidget {
  final bool isDescending;
  final String selectedSortOptions;

  // ignore: prefer_const_constructors_in_immutables
  FavouriteList(
      {Key? key, required this.isDescending, required this.selectedSortOptions})
      : super(key: key);

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  List<Food> favouriteList = [];

  String Id = currentId;

  Future getFavouriteList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot QuerySnapshot) {
      favouriteList.clear();
      QuerySnapshot.docs.forEach((doc) {
        Food food = Food(
          name: doc["name"],
          smallDescription: doc["small_description"],
          longDescription: doc["long_description"],
          thumbnailUrl: doc["thumbnail_url"],
          cookingTime: doc["cooking_time"],
          calories: doc["calories"],
          likes: doc["likes"],
          ingredientList: [],
        );
        favouriteList.add(food);
      });
    });
  }

  List<Food> get sortedList {
    switch (widget.selectedSortOptions) {
      case "Name":
        return favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
      case "Cooking Time":
        return favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.cookingTime.compareTo(item1.cookingTime)
              : item1.cookingTime.compareTo(item2.cookingTime));
      case "Calories":
        return favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.calories.compareTo(item1.calories)
              : item1.calories.compareTo(item2.calories));
      case "Likes":
        return favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.likes.compareTo(item1.likes)
              : item1.likes.compareTo(item2.likes));
      default:
        return favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFavouriteList(),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: favouriteList.length,
            itemBuilder: (_, i) {
              return FavouriteCard(food: sortedList[i]);
            },
          );
        });
  }
}

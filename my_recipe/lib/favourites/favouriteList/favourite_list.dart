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
  List<Food> favouriteFoodList = [];
  String id = currentId;

  Future<List<String>> getIdList(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      final List<dynamic>? favouriteIds =
          userSnapshot.data()!['favourites'] as List<dynamic>?;

      if (favouriteIds != null) {
        return favouriteIds.cast<String>();
      }
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getFavouritesList(
      List<String> favouriteIds) async {
    final List<Future<DocumentSnapshot<Map<String, dynamic>>>> futures = [];

    for (String id in favouriteIds) {
      final String trimmedId = id.trim();
      final Future<DocumentSnapshot<Map<String, dynamic>>> future =
          FirebaseFirestore.instance.collection('recipes').doc(trimmedId).get();

      futures.add(future);
    }

    final List<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        await Future.wait(futures);

    final List<Map<String, dynamic>> favouriteRecipes = snapshots
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data() ?? {})
        .toList();

    return favouriteRecipes;
  }

  Future displayFav() async {
    List<String> ids = await getIdList(id);
    List<Map<String, dynamic>> tempList = await getFavouritesList(ids);

    favouriteFoodList.clear();
    for (var element in tempList) {
      Food food = Food.convertToFood(element);
      favouriteFoodList.add(food);
    }
  }

  List<Food> get sortedList {
    switch (widget.selectedSortOptions) {
      case "Name":
        return favouriteFoodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
      case "Cooking Time":
        return favouriteFoodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.cookingTime.compareTo(item1.cookingTime)
              : item1.cookingTime.compareTo(item2.cookingTime));
      case "Calories":
        return favouriteFoodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.calories.compareTo(item1.calories)
              : item1.calories.compareTo(item2.calories));
      case "Likes":
        return favouriteFoodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.likes.compareTo(item1.likes)
              : item1.likes.compareTo(item2.likes));
      default:
        return favouriteFoodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: displayFav(),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: favouriteFoodList.length,
            itemBuilder: (_, i) {
              return FavouriteCard(food: sortedList[i]);
            },
          );
        });
  }
}

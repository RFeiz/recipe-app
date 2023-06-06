import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryPage/widgets/recipe_card.dart';
import 'package:my_recipe/home/categoryPage/widgets/recipe_card_skeleton.dart';
import 'package:my_recipe/models/food.dart';

class RecipeList extends StatefulWidget {
  final bool isDescending;
  final String selectedSortOptions;
  final String category;

  // ignore: prefer_const_constructors_in_immutables
  RecipeList(
      {Key? key,
      required this.isDescending,
      required this.selectedSortOptions,
      required this.category})
      : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<Food> foodList = [];

  Future<List<String>> getIdList(String catId) async {
    print(catId);
    final DocumentSnapshot<Map<String, dynamic>> catSnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(catId)
            .get();

    if (catSnapshot.exists) {
      final List<dynamic>? recipeIds =
          catSnapshot.data()!['recipes'] as List<dynamic>?;

      if (recipeIds != null) {
        return recipeIds.cast<String>();
      }
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getRecipesList(
      List<String> recipeIds) async {
    final List<Future<DocumentSnapshot<Map<String, dynamic>>>> futures = [];

    for (String id in recipeIds) {
      final Future<DocumentSnapshot<Map<String, dynamic>>> future =
          FirebaseFirestore.instance.collection('recipes').doc(id).get();

      futures.add(future);
    }

    final List<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        await Future.wait(futures);

    final List<Map<String, dynamic>> recipes = snapshots
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data() ?? {})
        .toList();

    return recipes;
  }

  Future displayRecipe() async {
    // List<String> ids = await getIdList(widget.category);
    // List<Map<String, dynamic>> tempList = await getRecipesList(ids);

    // foodList.clear();
    // for (var element in tempList) {
    //   Food food = Food.convertToFood(element);
    //   foodList.add(food);
    // }
  }

  List<Food> get sortedList {
    switch (widget.selectedSortOptions) {
      case "Name":
        return foodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
      case "Cooking Time":
        return foodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.cookingTime.compareTo(item1.cookingTime)
              : item1.cookingTime.compareTo(item2.cookingTime));
      case "Calories":
        return foodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.calories.compareTo(item1.calories)
              : item1.calories.compareTo(item2.calories));
      case "Likes":
        return foodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.likes.compareTo(item1.likes)
              : item1.likes.compareTo(item2.likes));
      default:
        return foodList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: displayRecipe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (foodList.isNotEmpty) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foodList.length,
                itemBuilder: (_, i) {
                  return RecipeCard(food: sortedList[i]);
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 125.0),
                child: Center(
                    child: Text(
                  "No recipe in this category list yet!",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                )),
              );
            }
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return const RecipeCardSkeleton();
              },
            );
          }
        });
  }
}

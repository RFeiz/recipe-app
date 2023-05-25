import 'package:flutter/material.dart';
import 'package:my_recipe/favourites/favouriteList/widgets/favourite_card.dart';
import 'package:my_recipe/models/food.dart';

class FavouriteList extends StatefulWidget {
  final bool isDescending;
  final String selectedSortOptions;

  FavouriteList(
      {Key? key, required this.isDescending, required this.selectedSortOptions})
      : super(key: key);

  final List<Food> favouriteList = [
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
        ingredientList: []),
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
        ingredientList: []),
    Food(
        name: "Ramen Noodles",
        smallDescription:
            "A chinese noodle dish with a fish-based broth and a variety of toppings.",
        longDescription:
            "A chinese noodle dish with a fish-based broth and a variety of toppings.",
        thumbnailUrl:
            "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
        cookingTime: "15m",
        calories: 450,
        likes: 785000000,
        ingredientList: []),
  ];

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  List<Food> get sortedList {
    switch (widget.selectedSortOptions) {
      case "Name":
        return widget.favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
      case "Cooking Time":
        return widget.favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.cookingTime.compareTo(item1.cookingTime)
              : item1.cookingTime.compareTo(item2.cookingTime));
      case "Calories":
        return widget.favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.calories.compareTo(item1.calories)
              : item1.calories.compareTo(item2.calories));
      case "Likes":
        return widget.favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.likes.compareTo(item1.likes)
              : item1.likes.compareTo(item2.likes));
      default:
        return widget.favouriteList
          ..sort((item1, item2) => widget.isDescending
              ? item2.name.compareTo(item1.name)
              : item1.name.compareTo(item2.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.favouriteList.length,
      itemBuilder: (_, i) {
        return FavouriteCard(food: sortedList[i]);
      },
    );
  }
}

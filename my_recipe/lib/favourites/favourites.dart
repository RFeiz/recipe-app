import 'package:flutter/material.dart';
import 'package:my_recipe/favourites/favouriteList/favourite_list.dart';
import 'package:my_recipe/widgets/custom_app_bar.dart';
import 'package:my_recipe/widgets/sorting_bar.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
              title: "Favourites",
              subTitle: "All your favourite recipes in one place"),
          const SortingBar(),
          FavouriteList()
        ],
      ),
    );
  }
}

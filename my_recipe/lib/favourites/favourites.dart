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
  bool isDescending = false;
  String selectedSortOptions = "Name";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
              title: "Favourites",
              subTitle: "All your favourite recipes in one place"),
          SortingBar(
            onSortChanged: (isDescending) {
              setState(() {
                this.isDescending = isDescending;
              });
            },
            onSortOptionChanged: (selectedSortOptions) {
              setState(() {
                this.selectedSortOptions = selectedSortOptions;
              });
            },
          ),
          FavouriteList(
            isDescending: isDescending,
            selectedSortOptions: selectedSortOptions,
          ),
        ],
      ),
    );
  }
}

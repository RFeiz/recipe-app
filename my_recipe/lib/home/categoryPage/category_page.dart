import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryPage/recipe_list.dart';

import 'package:my_recipe/models/category.dart';
import 'package:my_recipe/widgets/custom_app_bar.dart';
import 'package:my_recipe/widgets/sorting_bar.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  CategoryPage({super.key, required this.category});

  FoodCategory category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isDescending = false;
  String selectedSortOptions = "Name";
  String id = "";

  Future<String> getCatId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('name', isEqualTo: widget.category.name)
        .get();

    String id = querySnapshot.docs.first.id;
    print("In getCat: $id");
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
                title: widget.category.name,
                subTitle: widget.category.description,
                backIcon: true),
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
            RecipeList(
              isDescending: isDescending,
              selectedSortOptions: selectedSortOptions,
              category: id,
            ),
          ],
        ),
      ),
    );
  }
}

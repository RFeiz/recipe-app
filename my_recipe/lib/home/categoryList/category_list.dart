import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryList/widgets/category_card.dart';
import 'package:my_recipe/home/categoryList/widgets/category_card_skeleton.dart';

import '../../models/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<FoodCategory> categories = [];

  // get and retuen the category list
  Future getCategoryList() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((querySnapshot) {
      categories.clear();
      querySnapshot.docs.forEach((result) {
        categories.add(FoodCategory(
            name: result.data()["name"],
            imageUrl: result.data()["thumbnail_url"],
            description: result.data()["description"],
            numberOfRecipes: 0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categories[index]);
                // return CategoryCard(category: categories[index]);
              },
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const CategoryCardSkeleton();
              },
            );
          }
        });
  }
}

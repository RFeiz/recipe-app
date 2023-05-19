import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryList/widgets/category_card.dart';

import '../../models/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<FoodCategory> categories = [
    FoodCategory(
        name: "Mediterranean Diet",
        imageUrl:
            "https://images.unsplash.com/photo-1560717845-968823efbee1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
        description:
            "A diet that emphasizes fruits, vegetables, whole grains, legumes, nuts, and seeds. It also includes moderate amounts of fish and poultry, and low amounts of red meat and processed foods.",
        numberOfRecipes: 100),
    FoodCategory(
        name: "Ketogenic Diet",
        imageUrl:
            "https://images.unsplash.com/photo-1540420773420-3366772f4999?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=684&q=80",
        description:
            "A diet that is very low in carbohydrates and high in fat. It is designed to help people lose weight by putting their bodies into a state of ketosis, where they burn fat for energy instead of carbohydrates.",
        numberOfRecipes: 100),
    FoodCategory(
        name: "Vegan Diet",
        imageUrl:
            "https://images.unsplash.com/photo-1543362906-acfc16c67564?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=765&q=80",
        description:
            "A diet that excludes all animal products, including meat, poultry, seafood, eggs, and dairy.",
        numberOfRecipes: 100),
    FoodCategory(
        name: "Paleo Diet",
        imageUrl:
            "https://images.unsplash.com/photo-1551028150-64b9f398f678?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
        description:
            "A diet that is based on the foods that our hunter-gatherer ancestors ate. It is high in protein and low in carbohydrates, and it excludes processed foods, grains, legumes, and dairy.",
        numberOfRecipes: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}

// recipe_details.dart

import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';

class RecipeDetails extends StatelessWidget {
  final Food food;

  const RecipeDetails({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              food.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                food.longDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

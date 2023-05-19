import 'package:flutter/material.dart';
import 'package:my_recipe/models/category.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});

  final FoodCategory category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
                image: NetworkImage(widget.category.imageUrl),
                fit: BoxFit.cover)),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.7)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  widget.category.description.length > 70
                      ? widget.category.description.substring(0, 70) + '...'
                      : widget.category.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ]),
        ),
      ),
    ]);
  }
}

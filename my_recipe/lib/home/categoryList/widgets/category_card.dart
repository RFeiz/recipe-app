import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryPage/category_page.dart';
import 'package:my_recipe/models/category.dart';
import 'package:vibration/vibration.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});

  final FoodCategory category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Vibration.vibrate(duration: 200);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category: widget.category),
          ),
        );
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: NetworkImage(widget.category.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          // GRADIENT WHITE
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  ],
                  stops: [
                    0.0,
                    0.8
                  ])),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category.name,
                    // white and bold
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.category.description.length > 50
                        ? widget.category.description.substring(0, 90) + "..."
                        : widget.category.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}

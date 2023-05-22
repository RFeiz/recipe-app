// popular_card.dart

import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/recipe_details/recipe_details.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({Key? key, required this.food}) : super(key: key);

  final Food food;

  @override
  _PopularCardState createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(food: widget.food),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 45.0, left: 5, right: 5),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.food.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.175,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .scrim
                            .withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.food.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            widget.food.smallDescription.length > 50
                                ? "${widget.food.smallDescription.substring(0, 50)}..."
                                : widget.food.smallDescription,
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.favorite_border_outlined, color: Colors.red),
                              const SizedBox(width: 1.0),
                              Text(
                                widget.food.likes > 1000
                                    ? widget.food.likes > 1000000
                                        ? "${(widget.food.likes / 1000000).toStringAsFixed(1)}M"
                                        : "${(widget.food.likes / 1000).toStringAsFixed(1)}K"
                                    : widget.food.likes.toString(),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.watch_later_outlined, color: Colors.red),
                              const SizedBox(width: 1.0),
                              Text(
                                widget.food.cookingTime,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.local_fire_department_sharp, color: Colors.red),
                              const SizedBox(width: 1.0),
                              Text(
                                "${widget.food.calories} Kcal",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

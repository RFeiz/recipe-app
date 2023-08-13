import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/recipe_details/recipe_details.dart';
import 'package:vibration/vibration.dart';
import 'package:my_recipe/globals.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.food});

  final Food food;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (Globals.hapticFeedback) {
  Vibration.vibrate(duration: 200);
}
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetails(
                      food: widget.food,
                      onLikeChanged: (value) {},
                    )),
          );
        },
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: NetworkImage(widget.food.thumbnailUrl),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            // GRADIENT WHITE
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                    ],
                    stops: const [
                      0.0,
                      0.8
                    ])),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      widget.food.name,
                      // white and bold
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.food.smallDescription,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.favorite_border_outlined,
                                color: Colors.red),
                            const SizedBox(width: 1.0),
                            Text(
                                widget.food.likes > 1000
                                    ? widget.food.likes > 1000000
                                        ? "${(widget.food.likes / 1000000).toStringAsFixed(1)}M"
                                        : "${(widget.food.likes / 1000).toStringAsFixed(1)}K"
                                    : widget.food.likes.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.watch_later_outlined,
                                color: Colors.red),
                            const SizedBox(width: 1.0),
                            Text(widget.food.cookingTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.local_fire_department_sharp,
                                color: Colors.red),
                            const SizedBox(width: 1.0),
                            Text("${widget.food.calories} Kcal",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ]));
  }
}

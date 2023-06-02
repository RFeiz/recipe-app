import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/recipe_details/widgets/method_card.dart';
import 'package:my_recipe/recipe_details/widgets/method_card_wimg.dart';

class CookingMethod extends StatefulWidget {
  const CookingMethod({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  State<CookingMethod> createState() => _CookingMethodState();
}

class _CookingMethodState extends State<CookingMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: PageController(initialPage: 0, viewportFraction: 0.5),
          children: [
            MethodCardwimg(food: widget.food),
            for (var i = 0; i < 3; i++)
              MethodCard(
                title: "HEHE cook",
                stepDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan elit a enim ullamcorper tristique. Maecenas laoreet bibendum risus quis volutpat. Pellentesque accumsan lorem ante, et porttitor libero pellentesque ut. Morbi fermentum tincidunt erat, vel pretium velit luctus vestibulum. Donec eu euismod enim. Duis et massa congue, facilisis ex vitae, tincidunt ex. Vivamus commodo interdum iaculis. Aenean volutpat dapibus porttitor. Integer interdum felis arcu, vel rhoncus ipsum congue vel. Nunc.",
                currentStep: i + 1,
                totalSteps: widget.food.methodList.length,
              ),
          ],
        ),
      ),
    );
  }
}

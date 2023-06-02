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
            for (var i = 0; i < widget.food.methodList.length; i++)
              MethodCard(
                title: widget.food.methodList[i].title,
                stepDescription: widget.food.methodList[i].description,
                currentStep: i + 1,
                totalSteps: widget.food.methodList.length,
              ),
          ],
        ),
      ),
    );
  }
}

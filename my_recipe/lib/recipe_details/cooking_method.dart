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
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: PageView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          children: [
            MethodCardwimg(food: widget.food),
            for (var i = 0; i < widget.food.methodList.length; i++)
              MethodCard(
                pageController: _pageController,
                title: widget.food.methodList[i].title,
                stepDescription: widget.food.methodList[i].description,
                currentStep: i + 1,
                totalSteps: widget.food.methodList.length,
                duration: Duration(seconds: widget.food.methodList[i].time),
              ),
          ],
        ),
      ),
    );
  }
}

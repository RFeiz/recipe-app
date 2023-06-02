import 'package:custom_timer/custom_timer.dart';
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

class _CookingMethodState extends State<CookingMethod>
    with SingleTickerProviderStateMixin {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.5);

  late CustomTimerController _timeController = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 0),
      end: Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.seconds);

  @override
  void dispose() {
    _timeController.dispose(); // Dispose CustomTimerController
    _pageController.dispose(); // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.hourglass_bottom_rounded),
          onPressed: () {
            if (_timeController.state.value.name ==
                CustomTimerState.counting.name) {
              _timeController.pause();
            } else if (_timeController.state.value.name ==
                    CustomTimerState.paused.name ||
                _timeController.state.value.name ==
                    CustomTimerState.reset.name) {
              _timeController.start();
            }
          }),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomTimer(
              controller: _timeController,
              builder: (state, time) {
                return Text("${time.hours}h ${time.minutes}m ${time.seconds}s",
                    style: Theme.of(context).textTheme.titleLarge);
              }),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: PageView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          children: [
            MethodCardwimg(pageController: _pageController, food: widget.food),
            for (var i = 0; i < widget.food.methodList.length; i++)
              MethodCard(
                timeController: _timeController,
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

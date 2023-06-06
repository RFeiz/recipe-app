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

  List<bool> stepCompletedList = [];

  late CustomTimerController _timeController = CustomTimerController(
    vsync: this,
    begin: Duration(seconds: 0),
    end: Duration(),
    initialState: CustomTimerState.reset,
  );

  @override
  void initState() {
    super.initState();
    // Initialize the step completion state list
    stepCompletedList = List.generate(
      widget.food.methodList.length,
      (index) => false,
    );
  }

  @override
  void dispose() {
    _timeController.dispose(); // Dispose CustomTimerController
    _pageController.dispose(); // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          _timeController.remaining.value.duration.inSeconds > 0
              ? FloatingActionButton(
                  child: Icon(
                    _timeController.state.value.name ==
                            CustomTimerState.counting.name
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_timeController.state.value.name ==
                          CustomTimerState.counting.name) {
                        _timeController.pause();
                      } else if (_timeController.state.value.name ==
                              CustomTimerState.paused.name ||
                          _timeController.state.value.name ==
                              CustomTimerState.reset.name) {
                        _timeController.start();
                      }
                    });
                  })
              : null,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _timeController.remaining.value.duration.inSeconds != 0
            ? Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.scrim.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CustomTimer(
                    controller: _timeController,
                    builder: (state, time) {
                      return Text(
                          "${time.hours}h ${time.minutes}m ${time.seconds}s",
                          style: Theme.of(context).textTheme.titleLarge);
                    }),
              )
            : null,
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
                  stepCompleted:
                      stepCompletedList[i], // Pass the step completion state
                  onStepCompleted: () {
                    setState(() {
                      stepCompletedList[i] = !stepCompletedList[i];
                    });
                  },
                  onSetTimer: () {
                    setState(() {
                      // the timer
                      _timeController.begin =
                          Duration(seconds: widget.food.methodList[i].time);
                      _timeController.reset();
                    });
                  }),
          ],
        ),
      ),
    );
  }
}

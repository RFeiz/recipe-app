import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:my_recipe/globals.dart';
import 'package:my_recipe/models/food.dart';
import 'package:my_recipe/recipe_details/widgets/method_card.dart';
import 'package:my_recipe/recipe_details/widgets/method_card_wimg.dart';
import 'package:vibration/vibration.dart';

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
  int _currentPage = 0;

  List<bool> stepCompletedList = [];
  bool isAlarmPlaying = false;

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

  void playTimerCompletedSound() {
    FlutterRingtonePlayer.playAlarm();
    isAlarmPlaying = true;
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton? floatingButton_normal =
        _timeController.remaining.value.duration.inSeconds > 0 || isAlarmPlaying
            ? FloatingActionButton(
                heroTag: null,
                child: Icon(
                  _timeController.state.value.name ==
                          CustomTimerState.counting.name
                      ? Icons.pause
                      : isAlarmPlaying
                          ? Icons.stop
                          : Icons.play_arrow,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  Vibration.vibrate(duration: 200);
                  setState(() {
                    if (isAlarmPlaying) {
                      FlutterRingtonePlayer.stop();
                      isAlarmPlaying = false;
                    } else if (_timeController.state.value.name ==
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
            : null;

    Column floatingButton_easy = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        floatingButton_normal == null ? Container() : floatingButton_normal,
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _currentPage == 0
                  ? Container()
                  : Duration(
                                  seconds: widget
                                      .food.methodList[_currentPage - 1].time)
                              .inSeconds !=
                          0
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              setState(() {
                                // the timer
                                _timeController.begin = Duration(
                                    seconds: widget.food
                                        .methodList[_currentPage - 1].time);
                                _timeController.reset();
                              });
                            },
                            label: Text("Set Timer"),
                          ),
                        )
                      : Container(),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {
                    if (_pageController.page!.toInt() != 0)
                      stepCompletedList[_pageController.page!.toInt() - 1] =
                          true;

                    _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  });
                },
                child: _currentPage == 0
                    ? Icon(Icons.arrow_downward)
                    : Icon(Icons.done),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _timeController.remaining.value.duration.inSeconds > 0 ||
                isAlarmPlaying
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
                  builder:
                      (CustomTimerState state, CustomTimerRemainingTime time) {
                    if (time.duration.inSeconds < 3 && !isAlarmPlaying) {
                      playTimerCompletedSound();
                      return Text(
                        "Time's up!",
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    }
                    return Text(
                      "${time.hours}h ${time.minutes}m ${time.seconds}s",
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ))
            : null,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              print(value);
              _currentPage = value;
            });
          },
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
      floatingActionButton:
          Globals.easyAccess ? floatingButton_easy : floatingButton_normal,
    );
  }
}

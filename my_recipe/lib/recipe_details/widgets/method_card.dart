import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class MethodCard extends StatefulWidget {
  MethodCard(
      {super.key,
      required this.pageController,
      required this.title,
      required this.stepDescription,
      required this.currentStep,
      required this.totalSteps,
      this.duration = const Duration(seconds: 0)});

  PageController pageController;

  final String title;
  final String stepDescription;

  final int currentStep;
  final int totalSteps;

  final Duration duration;

  bool stepCompleted = false;

  @override
  State<MethodCard> createState() => _MethodCardState();
}

class _MethodCardState extends State<MethodCard>
    with SingleTickerProviderStateMixin {
  // late CustomTimerController _controller = CustomTimerController(
  //     vsync: this,
  //     begin: Duration(hours: 24),
  //     end: Duration(),
  //     initialState: CustomTimerState.counting,
  //     interval: CustomTimerInterval.milliseconds);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
          child: SizedBox(
            width: constraints.maxWidth,
            child: Card(
              child: Container(
                // display title (top center), step (top right), and description (center)
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      "Step ${widget.currentStep} of ${widget.totalSteps}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.stepDescription,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
                    widget.duration.inSeconds == 0
                        ? Container()
                        :
                        // display duration in hours h minutes m seconds s
                        Text(
                            "Waiting Time: ${widget.duration.inHours}h ${widget.duration.inMinutes % 60}m ${widget.duration.inSeconds % 60}s",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // button to set timer
                        widget.duration.inSeconds == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.surface,
                                      ),
                                      surfaceTintColor:
                                          MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.surface,
                                      )),
                                  onPressed: () {},
                                  child: Text(
                                    'Set Timer',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ),

                        // circle hollow button to mark as done . when click change to full circle
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.surface,
                              ),
                              surfaceTintColor:
                                  MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary,
                              )),
                          onPressed: () {
                            setState(() {
                              widget.stepCompleted = !widget.stepCompleted;
                              if (widget.stepCompleted) {
                                widget.pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                            });
                          },
                          child: Icon(
                            Icons.check,
                            color: widget.stepCompleted
                                ? Colors.green
                                : Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    // CustomTimer(
                    //   controller: _controller,
                    //   builder: (state, time) {
                    //     // Build the widget you want!🎉
                    //     return Text(
                    //         "${time.hours}:${time.minutes}:${time.seconds}.${time.milliseconds}",
                    //         style: TextStyle(fontSize: 24.0));
                    //   },
                    // ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

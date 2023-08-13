import 'package:flutter/material.dart';
import 'package:my_recipe/globals.dart';
import 'package:my_recipe/models/food.dart';
import 'package:vibration/vibration.dart';

// ignore: must_be_immutable
class MethodCardwimg extends StatefulWidget {
  MethodCardwimg({super.key, required this.pageController, required this.food});

  PageController pageController;

  final Food food;

  @override
  State<MethodCardwimg> createState() => _MethodCardwimgState();
}

class _MethodCardwimgState extends State<MethodCardwimg> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage(widget.food.thumbnailUrl),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: constraints.maxWidth,
                // GRADIENT WHITE
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                        ],
                        stops: [
                          0.0,
                          0.8
                        ])),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.food.name,
                              // white and bold
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.food.longDescription,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                              maxLines: 6,
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.surface,
                                ),
                                surfaceTintColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.primary,
                                )),
                            onPressed: () {
                              if (Globals.hapticFeedback) {
                                Vibration.vibrate(duration: 200);
                              }
                              setState(() {
                                widget.pageController.animateToPage(
                                    widget.pageController.page!.toInt() + 1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                            },
                            child: Icon(
                              Icons.arrow_downward,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
      },
    );
  }
}

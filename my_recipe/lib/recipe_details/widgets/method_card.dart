import 'package:flutter/material.dart';

class MethodCard extends StatefulWidget {
  const MethodCard(
      {super.key,
      required this.title,
      required this.stepDescription,
      required this.currentStep,
      required this.totalSteps,
      this.duration = const Duration(seconds: 0)});

  final String title;
  final String stepDescription;

  final int currentStep;
  final int totalSteps;

  final Duration duration;

  @override
  State<MethodCard> createState() => _MethodCardState();
}

class _MethodCardState extends State<MethodCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          // display title (top center) , step (top right) and description (center)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Step ${widget.currentStep} of ${widget.totalSteps}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.stepDescription,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

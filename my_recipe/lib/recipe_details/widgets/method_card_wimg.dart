import 'package:flutter/material.dart';

class MethodCardwimg extends StatefulWidget {
  const MethodCardwimg(
      {super.key,
      required this.stepDescription,
      required this.currentStep,
      required this.totalSteps,
      this.duration = const Duration(seconds: 0)});

  final String stepDescription;

  final int currentStep;
  final int totalSteps;

  final Duration duration;

  @override
  State<MethodCardwimg> createState() => _MethodCardwimgState();
}

class _MethodCardwimgState extends State<MethodCardwimg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Step ${widget.currentStep} of ${widget.totalSteps}",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
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

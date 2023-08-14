import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:my_recipe/globals.dart';

class SortingBar extends StatefulWidget {
  final ValueChanged<bool> onSortChanged;
  final ValueChanged<String> onSortOptionChanged;

  const SortingBar(
      {Key? key,
      required this.onSortChanged,
      required this.onSortOptionChanged})
      : super(key: key);

  @override
  State<SortingBar> createState() => _SortingBarState();
}

class _SortingBarState extends State<SortingBar> {
  bool isDescending = false;
  String selectedSortOption = "Name";

  List<String> sortOptions = [
    "Name",
    "Cooking Time",
    "Calories",
    "Likes",
  ];

  void checkVibrate(){
    if(Globals.hapticFeedback){
      Vibration.vibrate(duration: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          icon: Icon(
            Icons.sort,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
          label: Text(
            selectedSortOption,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.color
                    ?.withOpacity(0.5)),
          ),
          onPressed: () {
            checkVibrate();
            setState(() {
              selectedSortOption = getNextSortOption(selectedSortOption);
            });
            widget.onSortOptionChanged(selectedSortOption);
            widget.onSortChanged(isDescending);
          },
        ),
        IconButton(
          icon: Icon(
            isDescending ? Icons.arrow_downward : Icons.arrow_upward,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
          onPressed: () {
            checkVibrate();
            setState(() {
              isDescending = !isDescending;
            });
            widget.onSortOptionChanged(selectedSortOption);
            widget.onSortChanged(isDescending);
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02)
      ],
    );
  }

  String getNextSortOption(String currentOption) {
    final currentIndex = sortOptions.indexOf(currentOption);
    final nextIndex = (currentIndex + 1) % sortOptions.length;
    return sortOptions[nextIndex];
  }
}

import 'package:flutter/material.dart';

class SortingBar extends StatefulWidget {
  const SortingBar({super.key});

  @override
  State<SortingBar> createState() => _SortingBarState();
}

class _SortingBarState extends State<SortingBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.sort,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
          const SizedBox(width: 7.0),
          Text(
            "Sort by",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.color
                    ?.withOpacity(0.5)),
          ),
          const SizedBox(width: 7.0),
          Icon(
            Icons.arrow_downward,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

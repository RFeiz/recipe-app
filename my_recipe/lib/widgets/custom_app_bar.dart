import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar(
      {super.key,
      required this.title,
      required this.subTitle,
      this.backIcon = false});

  final String title;
  final String subTitle;
  final bool backIcon;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.backIcon
              ? Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Text(widget.subTitle,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

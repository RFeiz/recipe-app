import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:my_recipe/globals.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({
    Key? key,
    required this.title,
    required this.subTitle,
    this.profileIcon = false,
    this.backIcon = false,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final bool backIcon;
  final bool profileIcon;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.317;
    if (MediaQuery.of(context).size.height < appBarHeight) {
      appBarHeight = MediaQuery.of(context).size.height;
    }
    return SizedBox(
      height: appBarHeight,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.backIcon)
            Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (Globals.hapticFeedback) {
                            Vibration.vibrate(duration: 200);
                          }
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      const SizedBox(
                          width:
                              10), // Add some spacing between IconButton and Text
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.82, // Set your preferred width here
                        child: Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1, // Allow only one line of text
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.subTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          else if (widget.profileIcon)
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.11,
                    height: MediaQuery.of(context).size.width * 0.11,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(FirebaseAuth
                                .instance.currentUser?.photoURL
                                ?.toString() ??
                            'https://plus.unsplash.com/premium_photo-1668447597472-d16e3fec1618?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.subTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    widget.subTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

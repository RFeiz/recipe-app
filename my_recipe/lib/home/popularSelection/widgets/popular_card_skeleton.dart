// popular_card.dart

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PopularCardSkeleton extends StatefulWidget {
  const PopularCardSkeleton({Key? key}) : super(key: key);

  @override
  _PopularCardSkeleton createState() => _PopularCardSkeleton();
}

class _PopularCardSkeleton extends State<PopularCardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Center(
            child: Skeleton(
              isLoading: true,
              child: Text("Skeleton"),
              skeleton: Container(
                margin: const EdgeInsets.only(bottom: 45.0, left: 5, right: 5),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.175,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.scrim.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          isLoading: true,
                          child: Text("Skeleton"),
                          skeleton: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Skeleton(
                            isLoading: true,
                            child: Text("Skeleton"),
                            skeleton: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300],
                              ),
                            )),
                      ],
                    ),
                    Skeleton(
                      isLoading: true,
                      child: Text("Skeleton"),
                      skeleton: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

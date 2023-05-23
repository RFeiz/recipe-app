import 'package:flutter/material.dart';
import 'package:my_recipe/models/food.dart';

class FavouriteCard extends StatefulWidget {
  const FavouriteCard({super.key, required this.food});

  final Food food;

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.only(bottom: 20.0, left: 15, right: 5),
    //       height: MediaQuery.of(context).size.height * 0.125,
    //       width: MediaQuery.of(context).size.width * 0.2,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(7.0),
    //           image: DecorationImage(
    //               image: NetworkImage(widget.food.thumbnailUrl),
    //               fit: BoxFit.cover)),
    //     ),
    //     Stack(
    //       children: [
    //         Container(
    //           height: MediaQuery.of(context).size.height * 0.1,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(7.0),
    //             color: Theme.of(context).colorScheme.surface,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.withOpacity(0.5),
    //                 spreadRadius: 2,
    //                 blurRadius: 5,
    //                 offset: const Offset(0, 3),
    //               )
    //             ],
    //           ),
    //           child: Text(widget.food.name,
    //               style: Theme.of(context).textTheme.titleSmall),
    //         ),
    //       ],
    //     ),
    //   ],
    // );

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 15, bottom: 10),
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.225,
          height: MediaQuery.of(context).size.height * 0.125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            image: DecorationImage(
                image: NetworkImage(widget.food.thumbnailUrl),
                fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(7.0),
                    bottomRight: Radius.circular(7.0)),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.scrim.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(widget.food.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(
                      widget.food.smallDescription.length > 35
                          ? "${widget.food.smallDescription.substring(0, 35)}..."
                          : widget.food.smallDescription,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 3.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.watch_later_outlined,
                                  color: Colors.red),
                              const SizedBox(width: 1.0),
                              Text(widget.food.cookingTime,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ]),
                        Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.local_fire_department_sharp,
                                  color: Colors.red),
                              const SizedBox(width: 1.0),
                              Text("${widget.food.calories} Kcal",
                                  style: Theme.of(context).textTheme.bodySmall)
                            ]),
                      ]),
                  const SizedBox(height: 3.0),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_app/dataStructures/foodStructure.dart';

class FoodCard extends StatefulWidget {
  const FoodCard(
      {Key? key, required this.food, required this.width, required this.height})
      : super(key: key);

  final Food food;
  final double width;
  final double height;

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    width: 120,
                    height: 120,
                    image: NetworkImage(
                      widget.food.image,
                      scale: 1.0,
                    )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(widget.food.name),
            Text(widget.food.description),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.food.calories.toString() + " Kcal"),
                  IconButton(
                      onPressed: () => {
                            setState(() {
                              widget.food.isFavorite = !widget.food.isFavorite;
                            })
                          },
                      icon: Icon(
                        widget.food.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

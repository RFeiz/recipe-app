import 'package:flutter/material.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({Key? key}) : super(key: key);

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREjSFXBYiIVBaAkj5X4x8UsWSaGugO_eHXYQ&usqp=CAU',
                  scale: 1.0,
                )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text("Food Name"),
            Text("Food Description"),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("100 Kcal"),
                  IconButton(
                      onPressed: () => {}, icon: Icon(Icons.heart_broken))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

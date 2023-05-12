import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/foodCard.dart';
import 'package:recipe_app/widgets/foodListView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, User2213"),
            Text("what are you cooking today?"),
            SizedBox(height: 20),
            FoodListView(),
            SizedBox(height: 50),
            Text("Trending Dinner"),
            FoodCard()
          ],
        ),
      ),
    );
  }
}

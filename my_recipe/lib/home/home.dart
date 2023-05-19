import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryList/category_list.dart';
import 'package:my_recipe/home/popularSelection/popular_list.dart';
import 'package:my_recipe/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: "Hello Sarwin",
            subTitle: "What will you be cooking today?",
          ),
          PopularList(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Meal Categories",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          const CategoryList()
        ],
      ),
    );
  }
}

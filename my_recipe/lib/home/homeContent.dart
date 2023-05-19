import 'package:flutter/material.dart';
import 'package:my_recipe/home/categoryList/categoryList.dart';
import 'package:my_recipe/home/popularSelection/popularList.dart';
import 'package:my_recipe/widgets/customAppBar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
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
          CategoryList()
        ],
      ),
    );
  }
}

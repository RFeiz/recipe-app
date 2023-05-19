import 'package:flutter/material.dart';
import 'package:my_recipe/home/homeContent.dart';
import 'package:my_recipe/widgets/customAppBar.dart';

import 'package:my_recipe/widgets/customNavigationBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.search),
        ),
        body: HomeContent(),
        bottomNavigationBar: CustomNavigationBar());
  }
}

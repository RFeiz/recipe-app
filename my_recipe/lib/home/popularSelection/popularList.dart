import 'package:flutter/material.dart';
import 'package:my_recipe/home/popularSelection/widgets/popularCard.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10),
      child: PageView.builder(
        itemCount: 10,
        controller: PageController(viewportFraction: 0.82),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return PopularCard();
        },
      ),
    );
  }
}

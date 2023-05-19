import 'package:flutter/material.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({super.key});

  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 45.0, left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Pasta with Tomato Sauce",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.favorite_border_outlined,
                                    color: Colors.red),
                                SizedBox(width: 1.0),
                                Text("45k",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ]),
                          Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,
                                    color: Colors.red),
                                SizedBox(width: 1.0),
                                Text("30min",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ]),
                          Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.local_fire_department_sharp,
                                    color: Colors.red),
                                SizedBox(width: 1.0),
                                Text("1200Kcal",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ]),
                        ])
                  ],
                )),
          )
        ],
      ),
    );
  }
}

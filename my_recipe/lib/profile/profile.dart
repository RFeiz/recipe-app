import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 64,
              backgroundImage: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fhypebae.com%2F2020%2F7%2Fapple-emoji-memoji-update-iphone-ipad-face-masks-transgender-symbol-bubble-tea-tamale&psig=AOvVaw0JfQ9APlfXmfB0T1tjRqdh&ust=1685122310395000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCKDc4Pv_kP8CFQAAAAAdAAAAABAD'),
            ),
            const SizedBox(height: 16),
            const Text(
              'geerish',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Liked Recipes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _counter,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text('Recipe ${index + 1}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement theme selection logic
              },
              child: const Text('Choose a Theme'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logout logic
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe/profile/theme_Select.dart';
import 'package:my_recipe/widgets/custom_app_bar.dart';

import '../login/loginPage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // ignore: prefer_const_constructors
        return ThemeSelectDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomAppBar(
            title: "Profile", subTitle: "Manage your profile settings here."),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80'),
              ),
              const SizedBox(height: 16),
              const Text(
                'geerish',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
                  // Implement theme selection logic
                  _showThemeSelectionDialog(context);
                },
                child: const Text('Choose a Theme'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  //Implement logout logic
                  FirebaseAuth.instance.signOut();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

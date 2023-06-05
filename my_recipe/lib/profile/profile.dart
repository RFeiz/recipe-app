import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser?.photoURL
                        .toString() ??
                    'https://plus.unsplash.com/premium_photo-1668447597472-d16e3fec1618?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
              ),
              const SizedBox(height: 16),
              Text(
                FirebaseAuth.instance.currentUser?.displayName.toString() ??
                    'USER',
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
                onPressed: () async {
                  // Sign out from Firebase Authentication
                  await FirebaseAuth.instance.signOut();

                  // Sign out from Google Sign-In
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  await googleSignIn.signOut();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
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

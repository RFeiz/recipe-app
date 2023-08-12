import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_recipe/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/loginPage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.onThemeChanged});

  final Function(ThemeMode) onThemeChanged;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ThemeMode _selectedTheme = ThemeMode.system;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<ThemeMode> _getThemeMode() async {
    final SharedPreferences prefs = await _prefs;
    final int? themeMode = prefs.getInt('themeMode');
    if (themeMode == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[themeMode];
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _selectedTheme = mode;
      widget.onThemeChanged(mode);
    });
  }

  bool _isHapticFeedbackEnabled = false;
  bool _isEasyAccessEnabled = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _getThemeMode().then((ThemeMode mode) {
        _selectedTheme = mode;
      });
    });

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBar(
          title: "Profile",
          subTitle: "Manage your profile settings here.",
          profileIcon: false,
        ),
        Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(FirebaseAuth
                            .instance.currentUser?.photoURL
                            .toString() ??
                        'https://plus.unsplash.com/premium_photo-1668447597472-d16e3fec1618?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                FirebaseAuth.instance.currentUser?.displayName.toString() ??
                    'USER',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height *
                0.1), // Spacer should be set to 0.03

        // Accessibility Section
          Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Accessibility",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),


        // Voice Command Toggle
        Padding(
          padding: EdgeInsets.only(left: 1.0), // Adjust the left padding as needed
          child: SwitchListTile(
            title: Text('Easy Access'),
            value: _isEasyAccessEnabled,
            onChanged: (value) {
              setState(() {
                _isEasyAccessEnabled = value;
                //  voice command enabling/disabling
              });
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

        Padding(
          padding: EdgeInsets.only(left: 1.0), // Adjust the left padding as needed
          child: SwitchListTile(
          title: Text('Haptic Feedback'),
          value: _isHapticFeedbackEnabled,
          onChanged: (value) {
            setState(() {
              _isHapticFeedbackEnabled = value;
              // text-to-speech enabling/disabling
            });
          },
        ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        Text("Visuals & Styles",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                MediaQuery.of(context).size.height * 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Implement theme selection logic
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Select a Theme'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile(
                        title: Text('Light Theme'),
                        value:
                            ThemeMode.light, // Value for the first radio button
                        groupValue: _selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            setThemeMode(value as ThemeMode);
                          });
                        },
                        // Add any additional customizations to the RadioListTile, like subtitle, secondary, etc.
                      ),
                      RadioListTile(
                        title: Text(
                            'Dark Theme'), // Text for the first radio button
                        value:
                            ThemeMode.dark, // Value for the first radio button
                        groupValue: _selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            setThemeMode(value as ThemeMode);
                          });
                        },
                        // Add any additional customizations to the RadioListTile, like subtitle, secondary, etc.
                      ),
                      RadioListTile(
                        title: const Text(
                            'System Theme'), // Text for the first radio button
                        value: ThemeMode
                            .system, // Value for the first radio button
                        groupValue: _selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            setThemeMode(value as ThemeMode);
                          });
                        },
                        // Add any additional customizations to the RadioListTile, like subtitle, secondary, etc.
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Back'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Change Theme',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        // Danger Zone
        Text("Danger Zone",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorScheme.fromSwatch().error,
            foregroundColor: Colors.white,
            fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                MediaQuery.of(context).size.height * 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Log Out'),
                    content: const Text(
                        'Are you sure you want to log out? You will be redirected to the login page.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Sign out from Firebase Authentication
                          await FirebaseAuth.instance.signOut();

                          // Sign out from Google Sign-In
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          await googleSignIn.signOut();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text(
                          'Log Out',
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Text('Log Out',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Delete Account',
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          'Are you sure you want to delete your account?'),
                      const SizedBox(height: 8),
                      const Text(
                        'Note that this action cannot be undone. All your data will be lost.',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Sign out from Firebase Authentication
                        print(FirebaseAuth.instance.currentUser?.uid);

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .delete()
                            .then((value) =>
                                {FirebaseAuth.instance.currentUser?.delete()});

                        final GoogleSignIn googleSignIn = GoogleSignIn();
                        await googleSignIn.signOut();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Delete Account, I\'m sure!',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            child: Text(
              'Delete Account',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorScheme.fromSwatch().error),
            ),
          ),
        ),
      ],
    ));
  }
}

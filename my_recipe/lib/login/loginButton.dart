import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _loading = true;
        });
        signInWithGoogle(context: context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: _loading // keep the size of the button consistent
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : Text('Sign in with Google'),
    );
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          // Check if the user document already exists in the 'users' collection
          final userRef =
              FirebaseFirestore.instance.collection('users').doc(user.uid);
          final userSnapshot = await userRef.get();

          if (!userSnapshot.exists) {
            // Create a document for the user in the 'users' collection
            final userData = {
              'favourites': [],
              // Add additional user data fields as needed
            };

            await userRef.set(userData);
          }

          setState(() {
            _loading = false;
          });

          // Navigate to MainView
          Navigator.pushReplacementNamed(context, '/main');
        }
      }
    } on PlatformException catch (e) {
      print('PlatformException - code: ${e.code}, message: ${e.message}');
      print('Stack trace:\n${e.stacktrace}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.code}'),
        ),
      );
    } catch (e) {
      print('Error signing in with Google: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }

    setState(() {
      _loading = false;
    });
  }
}

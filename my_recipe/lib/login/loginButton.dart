import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key}) : super(key: key);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithGoogle(context: context);
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFDB4437),
        onPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: const Text("Sign in with Google"),
    );
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

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
          // Create a document for the user in the 'users' collection
          final userData = {
            'favourites': [],
            // Add additional user data fields as needed
          };

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userData);

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
  }
}

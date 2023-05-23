import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginButton extends StatelessWidget {
  LoginButton({super.key});
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithGoogle();
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFDB4437),
        onPrimary: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: const Text("Sign in with Google"),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Do something with the signed-in user
    } catch (e) {
      print(e.toString());
    }
  }
}

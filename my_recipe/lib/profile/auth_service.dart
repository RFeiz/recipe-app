import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the Google sign-in flow.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the authentication details from the Google user.
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential using the Google authentication details.
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential.
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential;
  } catch (error) {
    // Handle any sign-in errors.
    print("Error signing in with Google: $error");
    return null;
  }
}

Future<void> signOut() async {
  try {
    await _auth.signOut();
    await _googleSignIn.signOut();
  } catch (error) {
    // Handle any sign-out errors.
    print("Error signing out: $error");
  }
}

Future<User?> getCurrentUser() async {
  final User? user = _auth.currentUser;
  return user;
}
// Add other authentication-related functions as needed...


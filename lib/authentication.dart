import 'package:collabflutter/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? uid;
  String? name;
  String? userEmail;
  String? imageURL;

  Future<User?> signInWithGoogle() async {
    User? user;

    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(googleProvider);
      user = userCredential.user;
    } catch (e) {
      ScaffoldMessenger(
        child: SnackBar(
          backgroundColor: Color(0xFFB82E2E),
          content: Text('There\'s an error.')
        )
      );
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageURL = user.photoURL;
    }
    
    return user;
  }

  void signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    uid = null;
    name = null;
    userEmail = null;
    imageURL = null;
  }
}
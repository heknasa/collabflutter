import 'package:collabflutter/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? uid;
  String? name;
  String? userEmail;
  String? imageURL;

  Future<User?> signInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);
        user = userCredential.user;
      } catch (e) {
        ScaffoldMessenger(
          child: SnackBar(
            backgroundColor: Color(0xFFB82E2E),
            content: Text('There\'s an error.')
          )
        );
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount
          = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication
            = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );

        try {
          final UserCredential userCredential
              = await _auth.signInWithCredential(credential);
          user = userCredential.user;
        } catch (e) {
          ScaffoldMessenger(
            child: SnackBar(
              backgroundColor: Color(0xFFB82E2E),
              content: Text('There\'s an error.')
            )
          );
        }
      }
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

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: 
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error initializing firebase');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFE6E6E6)
                )
              ),
            );
          } else if (snapshot.hasData) {
            return MyApp();
          } return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SELAMAT DATANG',
                ),
                SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    GoogleAuth().signInWithGoogle();
                  },
                  child: Text('Masuk dengan Google')
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
import 'package:collabflutter/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabflutter/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFB82E2E),
      body: 
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error initializing firebase');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE6E6E6))
              ),
            );
          } else if (snapshot.hasData) {
            Navigator.pushNamed(context, '/main');
          } return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SELAMAT DATANG',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Color(0xFFE6E6E6),
                      fontWeight: FontWeight.w800,
                      fontSize: width <= 767 ? 72.0 * figmaFont * mobileFont : 72.0 * figmaFont
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                ElevatedButton(
                  onPressed: () {
                    GoogleAuth().signInWithGoogle();
                  },
                  child: Text(
                    'Masuk dengan Google',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontWeight: FontWeight.w700,
                        fontSize: width <= 767 ? 36.0 * figmaFont * mobileFont : 36.0 * figmaFont
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.05))),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width <= 767 ? width * 0.02 : width * 0.015)),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF1A1A1A)),
                    shadowColor: MaterialStateProperty.all(Color(0xFF1A1A1A)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Color(0xFFCCCCCC);
                    })
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
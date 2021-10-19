import 'package:collabflutter/screens/home_screen/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/states/auth_controller.dart';
import 'package:collabflutter/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import '../../services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabflutter/theme.dart';
import 'package:collabflutter/screens/home_screen/login_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Consumer(
        builder: (context, ref, child) {
          final authController = ref.watch(AuthController.authControllerProvider);
          if (authController != null) {
            return HomePage(width: width, height: height);
          } else {
            return LoginPage(width: width, height: height);
          }
        }
      )
    );
  }
}
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/states/auth_controller.dart';
import 'package:collabflutter/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import '../../services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabflutter/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/todo');
          },
          child: Text('Go to TODO'),
        )
      )
    );
  }
}
import 'dart:async';

import 'package:collabflutter/states/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends StatelessWidget {
  StreamSubscription<User?>? _authStateSubscription;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user != null) {
        String returnURL = Get.parameters['return'] ?? '/home';
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.offNamed(returnURL);
        });
      } else {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.offNamed('/login?return=');
        });
      }
    });
    _authStateSubscription?.cancel();
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {          
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}
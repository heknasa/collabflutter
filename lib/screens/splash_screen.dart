import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    StreamSubscription<User?>? _authStateSubscription;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
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
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(),
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/states/auth_control.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              width <= breakpoint ? 'SELAMAT\nDATANG' : 'SELAMAT DATANG',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: extrabold,
                  fontSize: width <= breakpoint ? headline2 * mobile : headline2
                ),
              ),
            SizedBox(height: height * 0.01),
            Consumer(
              builder: (context, ref, child) {
                final authController = ref.watch(AuthController.authControllerProvider);
                if (authController != null) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    String returnURL = Get.parameters['return'] ?? '/home';
                      Get.offNamed(returnURL);
                  });
                }
                return ElevatedButton(
                  onPressed: () async {
                    ref.watch(AuthController.authControllerProvider.notifier).signInWithGoogle();
                  },
                  child: Text(
                    'Masuk dengan Google',
                    style: TextStyle(
                      fontWeight: bold,
                      fontSize: width <= breakpoint? headline4 * mobile : headline4
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.05))),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width <= 767 ? width * 0.02 : width * 0.015)),
                  )
                );
              }
            ),
          ],
        ),
      )
    );
  }
}
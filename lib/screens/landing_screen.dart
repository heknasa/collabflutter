import 'package:collabflutter/states/auth_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/cupertino.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingScreen extends StatelessWidget{
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/landing.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sudah Muda',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontWeight: black,
                          fontSize: width <= breakpoint ? headline4 * mobile : headline4
                        )
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'where university students can connect, learn new things, dive into professional career, and have fun.',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.1),
                Text(
                  'Ready to Connect?',
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontWeight: bold,
                    fontSize: width <= breakpoint ? headline6 * mobile : headline6
                  )
                ),
                SizedBox(height: height * 0.02),
                HookConsumer(
                  builder: (context, ref, child) {
                    final authController = ref.watch(AuthController.authControllerProvider);
                    if (authController != null) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Get.offNamed('/home');
                      });
                    }
                    final AnimationController _animationController =
                        useAnimationController(
                          duration: Duration(milliseconds: 500),
                          lowerBound: 0,
                          upperBound: 5
                        )..repeat(reverse: true);
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return GestureDetector(
                          onTap: () {
                            ref.watch(AuthController.authControllerProvider.notifier).signInWithGoogle();
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: height * 0.05,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                child: Text(
                                  'MASUK DENGAN GOOGLE',
                                  style: TextStyle(
                                    color: Color(0xFFF2F2F2),
                                    fontWeight: bold,
                                    fontSize: width <= breakpoint ? headline5 * mobile : headline5
                                  )
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1A1A1A),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF2F2F2).withOpacity(0.2),
                                      blurRadius: _animationController.value,
                                      spreadRadius: _animationController.value
                                    )
                                  ]
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  },
                ),
                SizedBox(height: height * 0.15),
                Text(
                  'LEARN | INTERNSHIP | GAME',
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: width <= breakpoint ? headline6 * mobile : headline6,
                    fontWeight: bold
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
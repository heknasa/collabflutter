import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/todo');
              },
              child: const Text('Go to TODO'),
            ),
            SizedBox(),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/planner');
              },
              child: const Text('Go to PLAN'),
            )
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabflutter/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/todo');
        },
        child: Text('Go to TODO'),
      )
    );
  }
}
import 'package:collabflutter/models/internship_model.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';

import 'internship_dialog.dart';

class Internship extends StatelessWidget {  
  final InternshipModel internship;
  final double width;
  final double height;

  const Internship({
    Key? key,
    required this.internship,
    required this.width,
    required this.height,    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.01)
            ),
            elevation: height * 0.01,
            child: ListTile(
              // selimutin mouseregion
              title: Text(
                internship.position,
                style: TextStyle(
                  fontWeight: semibold,
                )
              ),
              subtitle: Text(
                internship.company,
                style: TextStyle(
                  fontWeight: medium,
                )
              ),
            ),
          ),
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) {
                return InternshipDialog(
                  internship: internship,
                  width: width,
                  height: height,                  
                );
              }
            );
          }
        ),
        SizedBox(height: height * 0.01)
      ],
    );
  }
}
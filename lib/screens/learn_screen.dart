import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabflutter/components/learn_widget.dart';
import 'package:collabflutter/components/theme_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LearnScreen extends StatelessWidget{
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/home');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 40.0,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                Text(
                  'LEARN',
                  style: TextStyle(
                    fontWeight: extrabold,
                    fontSize: width <= breakpoint ? headline4 * mobile : headline4
                  )
                ),
                SizedBox(height: height * 0.05),
                SizedBox(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline5 * mobile : headline5
                        )
                      ),
                      GridView.count(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        crossAxisSpacing: width * 0.01,
                        mainAxisSpacing: width * 0.01,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var i = 0; i < 6; i++)
                            Learn(
                              width: width,
                              height: height
                            )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.025),
                SizedBox(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Course',
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline5 * mobile : headline5
                        )
                      ),
                      GridView.count(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        crossAxisSpacing: width * 0.01,
                        mainAxisSpacing: width * 0.01,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var i = 0; i < 6; i++)
                            Learn(
                              width: width,
                              height: height
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
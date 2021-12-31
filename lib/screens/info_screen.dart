import 'package:collabflutter/components/internship_widget.dart';
import 'package:collabflutter/components/theme_switch.dart';
import 'package:collabflutter/states/internship_control.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InfoScreen extends StatelessWidget{
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<IconData> socmedIcon = [
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.envelope,
      FontAwesomeIcons.globe,
    ];
    List<String> socmedName = [
      'sudahmuda',
      'hello@sudahmuda.com',
      'sudahmuda.com'
    ];
    return Scaffold(
      body: Center(
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
              'INFO',
              style: TextStyle(
                fontWeight: extrabold,
                fontSize: width <= breakpoint ? headline4 * mobile : headline4
              )
            ),
            SizedBox(height: height * 0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < socmedIcon.length; i++)
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,                  
                        children: [                      
                          SizedBox.square(
                            dimension: 40.0,
                            child: Center(
                              child: FaIcon(
                                socmedIcon[i],
                                size: 30.0,
                              )
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            socmedName[i],
                            style: TextStyle(
                              fontWeight: semibold,
                              fontSize: width <= breakpoint ? headline6 * mobile : headline6
                            )
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
              ],
            ),
            SizedBox(height: height * 0.15),
            Text(
              'Copyright © 2021 Sudah Muda',
              style: TextStyle(
                fontWeight: medium,
                fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
              )
            )
          ],
        ),
      ),
    );
  }
}
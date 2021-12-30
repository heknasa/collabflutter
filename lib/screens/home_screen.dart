import 'package:collabflutter/states/auth_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collabflutter/components/theme_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<IconData> navIcon = [
      Icons.festival_rounded,
      Icons.business_center_rounded,
      Icons.sports_esports_rounded,
      Icons.info_rounded
    ];
    List<String> navTitle = ['LEARN', 'INTERNSHIP', 'GAME', 'INFO'];
    List<String> navLink = ['/learn', '/internship', '/game', '/info'];
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.0),
                  ThemeSwitch(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01)),
                            actionsPadding: EdgeInsets.all(width <= breakpoint ? width * 0.015 : width * 0.02),
                            title: Center(
                              child: Text(
                                'Log out?',
                                style: TextStyle(
                                  fontWeight: bold,
                                  fontSize: width <= breakpoint ? headline5 * mobile : headline5
                                ),
                              ),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Consumer(
                                  builder: (context, ref, child) {
                                    return TextButton(
                                      onPressed: () {
                                        ref.watch(AuthController.authControllerProvider.notifier).signOut();
                                      },
                                      child: Text(
                                        'IYA',
                                        style: TextStyle(
                                          fontSize: width <= breakpoint ? button * mobile : button
                                        ),
                                      )
                                    );
                                  }
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'ENGGAK',
                                    style: TextStyle(
                                      fontSize: width <= breakpoint ? button * mobile : button
                                    ),
                                  )
                                )
                              ],
                            ),
                          );
                        }
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.logout_rounded,
                        size: 30.0,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.05),
            Text(
              'Sudah Muda',
              style: TextStyle(
                fontWeight: black,
                fontSize: width <= breakpoint ? headline4 * mobile : headline4
              )
            ),
            SizedBox(height: height * 0.1),
            SizedBox(
              width: width * 0.6,
              child: Text(
                'Platform ini hadir buat kalian muda-mudi yang mau maksimalin masa kuliah dengan berkarya dan berpesta!',
                style: TextStyle(
                  fontSize: width <= breakpoint ? headline6 * mobile : headline6
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            SizedBox(
              width: width * 0.2,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.01,
                mainAxisSpacing: width * 0.01,
                children: [
                  for (var i = 0; i < navLink.length; i++) 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(navLink[i]);
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(height * 0.05),
                                ),
                                elevation: height * 0.01,
                                child: Icon(
                                  navIcon[i],
                                  size: 40.0,
                                )
                              ),
                            ),
                          ),
                        ),
                        Text(
                          navTitle[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width <= breakpoint ? caption * mobile : caption,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
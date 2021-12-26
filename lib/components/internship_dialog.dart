import 'package:collabflutter/models/internship_model.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InternshipDialog extends StatelessWidget {
  final InternshipModel internship;
  final double width;
  final double height;

  const InternshipDialog({
    Key? key,
    required this.internship,
    required this.width,
    required this.height,
  }) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    void _launchURL() async {
      await launch(internship.link);
    }
    Map<int, String?> role = {
      1: internship.role1,
      2: internship.role2,
      3: internship.role3,
      4: internship.role4,
      5: internship.role5,
    };
    Map<int, String?> qualification = {
      1: internship.qualification1,
      2: internship.qualification2,
      3: internship.qualification3,
      4: internship.qualification4,
      5: internship.qualification5,
    };
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(                              
                alignment: Alignment.topRight,
                margin: const EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close_rounded,
                      size: 40.0,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Text(
                internship.position,
                style: TextStyle(
                  fontWeight: extrabold,
                  fontSize: width <= breakpoint ? headline4 * mobile : headline4
                )
              ),
              SizedBox(height: height * 0.025),
              Text(
                internship.company,
                style: TextStyle(
                  fontWeight: bold,
                  fontSize: width <= breakpoint ? headline5 * mobile : headline5
                )
              ),
              SizedBox(height: height * 0.05),
              Container(
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Role',
                      style: TextStyle(
                        fontWeight: semibold,
                        fontSize: width <= breakpoint ? headline6 * mobile : headline6
                      )
                    ),
                    SizedBox(height: height * 0.01),
                    Column(
                      children: [
                        for (var i = 0; i < 5; i++) 
                          if (role[i + 1] == '')...[
                            const SizedBox.shrink()
                          ]
                          else ...[
                            Text(
                              '• ' + role[i + 1]!,
                              style: TextStyle(
                                fontWeight: regular,
                                fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                              )
                            )
                          ]
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Qualifications',
                      style: TextStyle(
                        fontWeight: semibold,
                        fontSize: width <= breakpoint ? headline6 * mobile : headline6
                      )
                    ),
                    SizedBox(height: height * 0.01),
                    Column(
                      children: [
                        for (var i = 0; i < 5; i++) 
                          if (qualification[i + 1] == '')...[
                            SizedBox.shrink()
                          ]
                          else ...[
                            Text(
                              '• ' + qualification[i + 1]!,
                              style: TextStyle(
                                fontWeight: regular,
                                fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                              )
                            )
                          ]
                      ]                     
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Profile',
                      style: TextStyle(
                        fontWeight: semibold,
                        fontSize: width <= breakpoint ? headline6 * mobile : headline6
                      )
                    ),
                    SizedBox(height: height * 0.01),
                    Column(
                      children: [
                        Text(
                          internship.companyProfile,
                          style: TextStyle(
                            fontWeight: regular,
                            fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              ElevatedButton(
                onPressed: _launchURL,
                child: Text(
                  'FIND OUT MORE',
                  style: TextStyle(
                    fontWeight: bold
                  ),
                )
              ),
              SizedBox(height: height * 0.1),
            ]
          ),
        ),
      ),
    );
  }
}
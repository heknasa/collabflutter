import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabflutter/components/payment_dialog.dart';
import 'package:collabflutter/components/video_dialog.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnDialog extends StatelessWidget {
  final double width;
  final double height;

  const LearnDialog({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        child: Scrollbar(
          isAlwaysShown: true,
          showTrackOnHover: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: height * 0.2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: 'https://source.unsplash.com/0MoF-Fe0w0A/',
                        fit: BoxFit.cover,
                      ),               
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4,
                            sigmaY: 4
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Stack(
                              children: [                                                  
                                Center(
                                  child: Container(
                                    width: width * 0.6,
                                    child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: SizedBox(
                                                width: width * 0.4,
                                                height: width * 0.4,                                            
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: 'https://source.unsplash.com/0MoF-Fe0w0A/',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Container(
                                                      alignment: Alignment.bottomCenter,
                                                      padding: EdgeInsets.only(bottom: height * 0.05),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text('HIDE')
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      },
                                      child: Text(
                                        'Belajar Digital Marketing lewat Instagram Paid Marketing Hacks',
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: extrabold,
                                          fontSize: width <= breakpoint ? headline6 : headline4
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 40.0,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),                    
                    ],
                  ),
                ),              
                SizedBox(height: height * 0.025),
                Column(
                  children: [
                    Text(
                      'Muhammad Anggoran',
                      style: TextStyle(
                        fontWeight: bold,
                        fontSize: width <= breakpoint ? headline5 * mobile : headline5
                      )
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      'System and Process Improvement Intern' + ' - ' + 'Grab Indonesia',
                      style: TextStyle(
                        fontWeight: bold,
                        fontSize: width <= breakpoint ? headline6 * mobile : headline6
                      )
                    ),
                  ],
                ),              
                SizedBox(height: height * 0.05),
                Container(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Topik Bahasan',
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6
                        )
                      ),
                      SizedBox(height: height * 0.01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• Job Description',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            ),
                          ),
                          Text(
                             '• Interview Experience',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            ),
                          ),
                          Text(
                            '• CV/Resume Review',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            ),
                          ),
                          Text(
                            '• JOB SIMULATION',
                            style: TextStyle(
                              fontWeight: semibold,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            ),
                          ),
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
                        'Tempat, Tanggal, dan Waktu',
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6
                        )
                      ),
                      SizedBox(height: height * 0.01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ' + 'Zoom Meetings Sudah Muda',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            )
                          ),
                          Text(
                            '• ' + 'Friday, January 1 2002',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            )
                          ),
                          Text(
                            '• ' + '19.00' + ' - ' + '20.00' + ' WIB',
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            )
                          )
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
                        'Profil Pemateri',
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6
                        )
                      ),
                      SizedBox(height: height * 0.01),
                      Column(
                        children: [
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {                        
                        return PaymentDialog(
                          width: width,
                          height: height
                        );
                      }
                    );
                  },
                  child: Text(
                    'GET',
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
      ),
    );
  }
}
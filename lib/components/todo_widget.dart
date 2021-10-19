import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'custom/custom_expansion_tile.dart';
import 'package:intl/intl.dart';
import 'todo_dialog.dart';
import 'package:collabflutter/states/todo_controller.dart';

class Todo extends StatelessWidget{
  final VoidCallback? onDone;
  final VoidCallback? onUpdate;
  final String judul;
  final String tanggal;
  final String waktu;
  final String kategori;
  final String deskripsi;
  final double width;
  final double height;

  const Todo({
    Key? key,
    required this.onDone,
    required this.onUpdate,
    required this.judul,
    required this.tanggal,
    required this.waktu,
    required this.kategori,
    required this.deskripsi,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final todoController = ref.watch(TodoController.todoControllerProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onDone,
              child: Icon(
                Icons.done_rounded,
                size: width <= 767 ? 20.0 * mobileIcon : 20.0,
                color: Color(0xFFE6E6E6),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Color(0xFF6BC76B);
                })
              ),
            ),
            Container(
              width: width * 0.6,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.05)
                ),
                color: Color(0xFFB82E2E),
                shadowColor: Color(0xFFB82E2E),
                elevation: height * 0.01,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent
                    ),
                    child: MyExpansionTile(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: Text(
                            deskripsi,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Color(0xFFE6E6E6),
                                fontWeight: FontWeight.w400,
                                fontSize: width <= 767 ? 20.0 * figmaFont * mobileFont : 20.0 * figmaFont 
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03)
                      ],
                      title: Text(
                        judul,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Color(0xFFE6E6E6),
                            fontWeight: FontWeight.w600,
                            fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont 
                          )
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tanggal + ' | ' + waktu,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Color(0xFFCCCCCC),
                                fontWeight: FontWeight.w400,
                                fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont 
                              )
                            ),
                          ),
                          Text(
                            kategori,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Color(0xFFCCCCCC),
                                fontWeight: FontWeight.w400,
                                fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont 
                              )
                            ),
                          )
                        ],
                      ),
                      //biar null lolos
                    ),
                  ),
                ),
              ),
            ),
            width <= 767
            ? Column(
              children: [
                ElevatedButton(
                  onPressed: onUpdate,
                  child: Icon(
                    Icons.edit_rounded,
                    size: width <= 767 ? 20.0 * mobileIcon : 20.0,
                    color: Color(0xFFE6E6E6),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Color(0xFFCCCCCC);
                    })
                  ),
                ),
                SizedBox(height: height *0.01),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.delete_rounded,
                    size: width <= 767 ? 20.0 * mobileIcon : 20.0,
                    color: Color(0xFFE6E6E6),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Color(0xFFB82E2E);
                    })
                  ),
                ),
              ],
            )
          : Row(
              children: [
                ElevatedButton(
                  onPressed: onUpdate,
                  child: Icon(
                    Icons.edit_rounded,
                    size: width * 0.015,
                    color: Color(0xFFE6E6E6),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width * 0.01)),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Color(0xFFCCCCCC);
                    })
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.delete_rounded,
                    size: width * 0.015,
                    color: Color(0xFFE6E6E6),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width * 0.01)),
                    backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Color(0xFFB82E2E);
                    })
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: height * 0.01)
      ],
    );
  }
}
import 'package:collabflutter/components/custom/custom_expansion_tile.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class Todo extends StatelessWidget{
  final VoidCallback? onDone;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;
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
    required this.onDelete,
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onDone,
              child: Icon(
                Icons.done_rounded,
                size: width <= breakpoint ? 20.0 * mobile : 20.0,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Colors.greenAccent;
                })
              ),
            ),
            SizedBox(
              width: width * 0.6,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.05)
                ),
                elevation: height * 0.01,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent
                    ),
                    child: HelloExpansionTile(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: Text(
                            deskripsi,
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03)
                      ],
                      title: Text(
                        judul,
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tanggal + ' | ' + waktu,
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? caption * mobile : caption
                            ),
                          ),
                          Text(
                            kategori,
                            style: TextStyle(
                              fontWeight: regular,
                              fontSize: width <= breakpoint ? caption * mobile : caption
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
            width <= breakpoint
            ? Column(
              children: [
                ElevatedButton(
                  onPressed: onUpdate,
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 20.0 * mobile,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                ),
                SizedBox(height: height *0.01),
                ElevatedButton(
                  onPressed: onDelete,
                  child: const Icon(
                    Icons.delete_rounded,
                    size: 20.0 * mobile,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Colors.redAccent;
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
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width * 0.01)),
                  ),
                ),
                ElevatedButton(
                  onPressed: onDelete,
                  child: Icon(
                    Icons.delete_rounded,
                    size: width * 0.015,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(width * 0.01)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return Colors.redAccent;
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
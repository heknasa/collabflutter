import 'package:collabflutter/components/custom/custom_convex_app_bar.dart';
import 'package:collabflutter/components/todo_dialog.dart';
import 'package:collabflutter/components/todo_widget.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:collabflutter/states/todo_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:collabflutter/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:collabflutter/states/auth_controller.dart';

class TodoScreen extends StatelessWidget{
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final _animationController = AnimationController(vsync: this) (hook);
    return Scaffold(
      // bottomNavigationBar: HelloConvexButton.fab(
      //   foregroundColor: Theme.of(context).colorScheme.onSurface,
      //   backgroundColor: Theme.of(context).colorScheme.surface,
      //   bottomMargin: height * 0.01,
      //   progress: _animationController,
      // ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton.extended(
            onPressed: () {
              ref.watch(themeMode.notifier).changeThemeMode();
            },
            label: Text(
              'THEME',
            )
          );
        }
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              Text(
                'TO DO LIST',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: width <= 767 ? 36.0 * figmaFont * mobileFont : 36.0 * figmaFont
                  )
                ),       
              ),
              SizedBox(height: height * 0.1),
              Consumer(
                builder: (context, ref, child) {
                  final todoController = ref.watch(TodoController.todoControllerProvider);
                  return todoController.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Todo(
                          onDone: () {
                            ref.watch(TodoController.todoControllerProvider.notifier).removeTodo(data[index].id ?? 'id');
                          },
                          onUpdate: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TodoDialog(
                                  button: 'UPDATE',
                                  todo: data[index],
                                  width: width,
                                  height: height
                                );
                              }
                            );
                          },
                          judul: data[index].judul ?? '',
                          tanggal: DateFormat('E, d/M/y').format((data[index].tanggal!).toDate()).toString(),
                          waktu: DateFormat('hh:mm a').format((data[index].waktu!).toDate()).toString(),
                          kategori: data[index].kategori ?? '',
                          deskripsi: data[index].deskripsi ?? '',
                          width: width,
                          height: height,
                        );
                      }
                    ),
                    loading: (_) => Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE6E6E6))
                      )
                    ),
                    error: (error, stack, _) => Center(
                      child: Text(error.toString())
                    )
                  );
                }
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return TodoDialog(
                        button: 'CREATE',
                        todo: TodoModel.empty(),
                        width: width,
                        height: height
                      );
                    }
                  );
                },
                child: Icon(
                  Icons.add_rounded,
                  size: width <= 767 ? 20.0 * mobileIcon : 20.0,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01))),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
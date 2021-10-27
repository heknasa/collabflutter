import 'package:collabflutter/components/todo_dialog.dart';
import 'package:collabflutter/components/todo_widget.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:collabflutter/states/todo_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/providers/theme_provider.dart';

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
      floatingActionButton: FloatingActionButton.extended(
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
        icon: const Icon(
          Icons.add_rounded,
        ),
        label: const Text(
          'CREATE',
          style: TextStyle(
            fontWeight: bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              Text(
                'TO DO LIST',
                style: TextStyle(
                  fontWeight: extrabold,
                  fontSize: width <= breakpoint ? headline4 * mobile : headline4
                )
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
                            TodoModel? _todo = data[index];
                            ref.watch(TodoController.todoControllerProvider.notifier).removeTodo(_todo.id ?? 'id');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.symmetric(horizontal: width <= breakpoint ? width * 0.1 : width * 0.2),
                                content: const Text(
                                  'SEMANGAT TERUS! \u{1F525}',
                                  style: TextStyle(
                                    fontWeight: semibold
                                  ),
                                ),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () => ref.read(TodoController.todoControllerProvider.notifier).addTodo(_todo)
                                ),
                              )
                            );
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
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01)),
                                  actionsPadding: EdgeInsets.all(width <= breakpoint ? width * 0.015 : width * 0.02),
                                  title: Center(
                                    child: Text(
                                      'Hapus?',
                                      style: TextStyle(
                                        fontWeight: bold,
                                        fontSize: width <= breakpoint ? headline5 * mobile : headline5
                                      ),
                                    ),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                      onPressed: () {
                                        ref.watch(TodoController.todoControllerProvider.notifier).removeTodo(data[index].id ?? 'id');
                                        Get.back();
                                      },
                                      child: Text(
                                        'IYA',
                                        style: TextStyle(
                                          fontSize: width <= breakpoint ? button * mobile : button
                                          ),
                                        )
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
                    loading: (_) => const Center(
                      child: RefreshProgressIndicator()
                    ),
                    error: (error, stack, _) => Center(
                      child: Text(error.toString())
                    )
                  );
                }
              ),
              SizedBox(height: height * 0.01),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      ref.watch(themeMode.notifier).changeThemeMode();
                    },
                    child: Icon(
                      Icons.palette,
                      size: width <= 767 ? 20.0 * mobile : 20.0,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01))),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      )
    );
  }
}
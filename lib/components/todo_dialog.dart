import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/states/todo_control.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabflutter/providers/theme_provider.dart';

class TodoDialog extends StatefulHookConsumerWidget {  
  final String button;
  final TodoModel todo;
  final double width;
  final double height;

  const TodoDialog({Key? key, required this.button, required this.todo, required this.width, required this.height}) : super(key: key);

  @override
  TodoDialogState createState() => TodoDialogState();
}

class TodoDialogState extends ConsumerState<TodoDialog> {
  DateTime? _time;
  DateTime? _date;
  TimeOfDay? _timeState;
  String? _problem;
  
  @override
  Widget build(BuildContext context) {
    final todoNotifier = ref.watch(TodoController.todoControllerProvider.notifier);
    final TextEditingController? _contJudul = useTextEditingController(text: widget.todo.judul);
    final TextEditingController? _contKategori = useTextEditingController(text: widget.todo.kategori);
    final TextEditingController? _contDeskripsi = useTextEditingController(text: widget.todo.deskripsi);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.01)),
      child: Container(
        margin: widget.width <= breakpoint ? EdgeInsets.all(widget.width * 0.04) : EdgeInsets.all(widget.width * 0.02),
        width: widget.width * 0.3,
        height: widget.width <= breakpoint ? widget.height * 0.6 : widget.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    widget.button == 'CREATE' ? 'CREATE TODO' : 'UPDATE TODO',
                    style: TextStyle(
                      fontWeight: bold,
                      fontSize: widget.width <= breakpoint ? headline5 * mobile : headline5
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        setState(() {
                          _date = null;
                          _timeState = null;
                        });
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: widget.width <= breakpoint ? 24.0 * mobile : 24.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: widget.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: widget.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _contJudul,
                      maxLength: 40,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        labelStyle: TextStyle(
                          fontWeight: bold,
                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        counterStyle: TextStyle(
                          fontWeight: light,
                          fontSize: widget.width <= breakpoint ? caption * mobile : caption
                        ),
                      ),
                      style: TextStyle(
                        fontWeight: regular,
                        fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deadline',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: bold,
                            fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                          ),
                        ),
                        SizedBox(height: widget.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  helpText: 'Deadline',
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: Theme.of(context),
                                      child: child!,
                                    );
                                  }
                                ).then((date) {
                                  _date = date;
                                  setState(() {
                                    _date = date;
                                    _problem = null;
                                  });
                                });
                              },
                              child: Text(
                                _date != null
                                ? DateFormat('E, d/M/y').format(_date!).toString()
                                : widget.todo.tanggal != null
                                ? DateFormat('E, d/M/y').format((widget.todo.tanggal!).toDate()).toString()
                                : 'show calendar',
                                style: TextStyle(
                                  fontWeight: medium,
                                  fontSize: widget.width <= breakpoint ? overline * mobile : overline,
                                  fontStyle: italic
                                ),
                              ),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(const BorderSide(width: 1.0)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.05)))
                              ),
                            ),
                            SizedBox(width: widget.width * 0.01),
                            OutlinedButton(
                              onPressed: () {
                                _date == null
                                ? setState(() {
                                  _problem = '*isi tanggal dulu';
                                })
                                : showTimePicker(
                                  context: context,
                                  helpText: 'Deadline',
                                  initialTime: TimeOfDay.now(),
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: Theme.of(context),
                                      child: child!,
                                    );
                                  }
                                ).then((time) {
                                  if (_date != null) {
                                    _time = DateTime(_date!.year, _date!.month, _date!.day, time!.hour, time.minute);
                                  }
                                  setState(() {
                                    _timeState = time;
                                  });
                                });
                              },
                              child: Text(
                                _timeState != null
                                ? _timeState!.format(context)
                                : widget.todo.waktu != null
                                ? DateFormat('hh:mm a').format((widget.todo.waktu!).toDate()).toString()
                                : 'show clock',
                                style: TextStyle(
                                  fontWeight: medium,
                                  fontSize: widget.width <= breakpoint ? overline * mobile : overline,
                                  fontStyle: italic
                                ),
                              ),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(const BorderSide(width: 1.0)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.05)))
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: widget.height * 0.02),
                    TextField(
                      controller: _contKategori,
                      maxLength: 20,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Kategori',
                        labelStyle: TextStyle(
                          fontWeight: bold,
                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        counterStyle: TextStyle(
                          fontWeight: light,
                          fontSize: widget.width <= breakpoint ? caption * mobile : caption
                        ),
                      ),
                      style: TextStyle(
                        fontWeight: regular,
                        fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2
                      ),
                    ),
                    TextField(
                      controller:_contDeskripsi,
                      maxLength: 200,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        labelStyle: TextStyle(
                          fontWeight: bold,
                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          )
                        ),
                        counterStyle: TextStyle(
                          fontWeight: light,
                          fontSize: widget.width <= breakpoint ? caption * mobile : caption
                        ),
                      ),
                      style: TextStyle(
                        fontWeight: regular,
                        fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.width * 0.01),
              ElevatedButton(
                onPressed: () {
                  if (widget.button == 'CREATE') {
                    if (_contJudul?.text.isNotEmpty == true && _date != null && _time != null && _contKategori?.text.isNotEmpty == true && _contDeskripsi?.text.isNotEmpty == true) {
                      todoNotifier.addTodo(
                        TodoModel(
                          judul: _contJudul!.text,
                          tanggal: Timestamp.fromDate(_date!),
                          waktu: Timestamp.fromDate(_time!),
                          kategori: _contKategori!.text,
                          deskripsi: _contDeskripsi!.text,
                        )
                      );
                      setState(() {
                        _date = null;
                        _timeState = null;
                      });
                      Get.back();
                    } else {
                      setState(() {
                        _problem = '*isi semua';
                      });  
                    }
                  } else if (widget.button == 'UPDATE') {
                    todoNotifier.editTodo(
                      TodoModel(
                        id: widget.todo.id,
                        judul: _contJudul == null ? widget.todo.judul :  _contJudul.text,
                        tanggal: _date == null ? widget.todo.tanggal : Timestamp.fromDate(_date!),
                        waktu: _time == null ? widget.todo.waktu : Timestamp.fromDate(_time!),
                        kategori: _contKategori == null ? widget.todo.kategori : _contKategori.text,
                        deskripsi: _contDeskripsi == null ? widget.todo.deskripsi : _contDeskripsi.text,
                      )
                    );
                    setState(() {
                      _date = null;
                      _timeState = null;
                    });
                    Get.back();
                  }
                },
                child: Text(
                  widget.button,
                  style: TextStyle(
                    fontWeight: extrabold,
                    fontSize: widget.width <= breakpoint ? button * mobile : button
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.01))),
                )
              ),
              SizedBox(height: widget.height * 0.01),
              _problem == null
              ? const SizedBox()
              : Text(
                _problem!,
                style: TextStyle(
                  fontSize: widget.width <= breakpoint ? caption * mobile : caption,
                  fontWeight: bold,
                  color: Colors.redAccent
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
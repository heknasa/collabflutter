import 'package:flutter/material.dart';
import 'package:collabflutter/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/states/todo_controller.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDialog extends ConsumerStatefulWidget {
  final double width;
  final double height;

  const TodoDialog({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  TodoDialogState createState() => TodoDialogState();
}

class TodoDialogState extends ConsumerState<TodoDialog> {
  DateTime? _time;
  DateTime? _date;
  TimeOfDay? _timeState;
  final _contJudul = TextEditingController();
  final _contKategori = TextEditingController();
  final _contDeskripsi = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final todoNotifier = ref.read(TodoController.todoControllerProvider.notifier);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.01)),
      backgroundColor: Color(0xFF333333),
      child: Container(
        margin: widget.width <= 767 ? EdgeInsets.all(widget.width * 0.04) : EdgeInsets.all(widget.width * 0.02),
        width: widget.width * 0.3,
        height: widget.width <= 767 ? widget.height * 0.6 : widget.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // return empty
                  Text(''),
                  Text(
                    'ADD TO DO',
                    style: textStyle(widget.width, Color(0xFFE6E6E6), FontWeight.w700, 36.0)
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _date = null;
                          _timeState = null;
                        });
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: widget.width <= 767 ? 24.0 * mobileIcon : 24.0,
                        color: Color(0xFFE6E6E6)
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
                      cursorColor: Color(0xFFCCCCCC),
                      maxLength: 40,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        labelStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w700, 24.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC)
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6)
                          )
                        ),
                        counterStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 16.0),
                      ),
                      style: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 24.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deadline',
                          style: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w700, 24.0)
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
                                  lastDate: DateTime.now().add(Duration(days: 365)),
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Color(0xFFE6E6E6),
                                          surface: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  }
                                ).then((date) {
                                  _date = date;
                                  setState(() {
                                    _date = date;
                                  });
                                });
                              },
                              child: Text(
                                _date != null ? DateFormat('E, d/M/y').format(_date!).toString() : 'show calendar',
                                  style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Color(0xFFCCCCCC),
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.width <= 767 ? 20.0 * figmaFont * mobileFont : 20.0 * figmaFont,
                                    fontStyle: FontStyle.italic
                                  )
                                )
                              ),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(color: Color(0xFFCCCCCC), width: 1.0)),
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.05)))
                              ),
                            ),
                            SizedBox(width: widget.width * 0.01),
                            OutlinedButton(
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  helpText: 'Deadline',
                                  initialTime: TimeOfDay.now(),
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Color(0xFFE6E6E6),
                                          surface: Color(0xFF1A1A1A),
                                          onSurface: Color(0xFF808080)
                                        ),
                                      ),
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
                                _timeState != null ? _timeState!.format(context) : 'show clock',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Color(0xFFCCCCCC),
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.width <= 767 ? 20.0 * figmaFont * mobileFont : 20.0 * figmaFont,
                                    fontStyle: FontStyle.italic
                                  )
                                )
                              ),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(color: Color(0xFFCCCCCC), width: 1.0)),
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                      cursorColor: Color(0xFFCCCCCC),
                      maxLength: 20,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Kategori',
                        labelStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w700, 24.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC)
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6)
                          )
                        ),
                        counterStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 16.0)
                      ),
                      style: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 24.0)
                    ),
                    TextField(
                      controller: _contDeskripsi,
                      cursorColor: Color(0xFFCCCCCC),
                      maxLength: 200,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        labelStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w700, 24.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC)
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6)
                          )
                        ),
                        counterStyle: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 16.0)
                      ),
                      style: textStyle(widget.width, Color(0xFFCCCCCC), FontWeight.w400, 24.0)
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.width * 0.01),
              ElevatedButton(
                onPressed: () {
                  todoNotifier.addTodo(
                    TodoModel(
                      judul: _contJudul.text,
                      tanggal: Timestamp.fromDate(_date!),
                      waktu: Timestamp.fromDate(_time!),
                      kategori: _contKategori.text,
                      deskripsi: _contDeskripsi.text,
                    )
                  );
                  setState(() {
                    _date = null;
                    _timeState = null;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'CREATE',
                  style: textStyle(widget.width, Color(0xFFE6E6E6), FontWeight.w800, 24.0),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.01))),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFB82E2E)),
                  shadowColor: MaterialStateProperty.all(Color(0xFFB82E2E)),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
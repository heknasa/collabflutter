import 'package:collabflutter/models/plan_model.dart';
import 'package:collabflutter/states/plan_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabflutter/providers/theme_provider.dart';

class PlanDialog extends StatefulHookConsumerWidget {  
  final String button;
  final PlanModel plan;
  final double width;
  final double height;

  const PlanDialog({Key? key, required this.button, required this.plan, required this.width, required this.height}) : super(key: key);

  @override
  PlanDialogState createState() => PlanDialogState();
}

class PlanDialogState extends ConsumerState<PlanDialog> {
  DateTime? _time;
  DateTime? _date;
  TimeOfDay? _timeState;
  String? _problem;
  
  @override
  Widget build(BuildContext context) {
    final planNotifier = ref.watch(PlanController.planControllerProvider.notifier);
    final TextEditingController? _contAgenda = useTextEditingController(text: widget.plan.agenda);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.width * 0.01)),
      child: Container(
        margin: widget.width <= breakpoint ? EdgeInsets.all(widget.width * 0.04) : EdgeInsets.all(widget.width * 0.02),
        width: widget.width * 0.3,
        height: widget.width <= breakpoint ? widget.height * 0.4 : widget.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    widget.button == 'CREATE' ? 'CREATE PLAN' : 'UPDATE PLAN',
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
                      controller: _contAgenda,
                      maxLength: 40,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Agenda',
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
                          'Tanggal',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: bold,
                            fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                          ),
                        ),
                        SizedBox(height: widget.height * 0.01),
                        OutlinedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              helpText: 'Tanggal',
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
                            : widget.plan.tanggal != null
                            ? DateFormat('E, d/M/y').format((widget.plan.tanggal!).toDate()).toString()
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
                      ],
                    ),
                    SizedBox(height: widget.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: bold,
                            fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                          ),
                        ),
                        SizedBox(height: widget.height * 0.01),
                        OutlinedButton(
                          onPressed: () {
                            _date == null
                            ? setState(() {
                              _problem = '*isi tanggal dulu';
                            })
                            : showTimePicker(
                              context: context,
                              helpText: 'Waktu',
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
                            : widget.plan.waktu != null
                            ? DateFormat('hh:mm a').format((widget.plan.waktu!).toDate()).toString()
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
              ),
              SizedBox(height: widget.width * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (widget.button == 'CREATE') {
                    if (_contAgenda?.text.isNotEmpty == true && _date != null && _time != null) {
                      planNotifier.addPlan(
                        PlanModel(
                          agenda: _contAgenda!.text,
                          tanggal: Timestamp.fromDate(_date!),
                          waktu: Timestamp.fromDate(_time!),
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
                    planNotifier.editPlan(
                      PlanModel(
                        id: widget.plan.id,
                        agenda: _contAgenda == null ? widget.plan.agenda :  _contAgenda.text,
                        tanggal: _date == null ? widget.plan.tanggal : Timestamp.fromDate(_date!),
                        waktu: _time == null ? widget.plan.waktu : Timestamp.fromDate(_time!),
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
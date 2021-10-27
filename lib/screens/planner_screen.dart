import 'dart:collection';

import 'package:collabflutter/components/plan_dialog.dart';
import 'package:collabflutter/services/plan_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabflutter/models/plan_model.dart';
import 'package:collabflutter/states/plan_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collabflutter/components/build_marker.dart';

// card-listtile, calendar-crud

class PlannerScreen extends ConsumerStatefulWidget{
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  PlannerScreenState createState() => PlannerScreenState();
}

class PlannerScreenState extends ConsumerState<PlannerScreen> {
  DateTime? _selectedDay;
  DateTime? _focusedDay = DateTime.now();
  final Map<DateTime, List> _agendaList = {};
  List _convert = [];
  final List _conversion = [];
  final List<DateTime> _date = [];

  Future<Map<DateTime, List<dynamic>>> getPlan() async {
    final calendarContents = await FirebaseFirestore.instance
        .collection('plans')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('plan').get();
    ;
    for (var calendarContent in calendarContents.docs) {
      _conversion.add([
        calendarContent['tanggal']
      ]);
      _date.add(DateTime.parse(DateFormat('yyyy-MM-dd').format(calendarContent['tanggal'].toDate())));
    }
    for (var indices =0; indices < _date.length; indices ++) {
      for (var index = indices; index < _date.length; index++) {
        if (DateTime.parse(DateFormat('yyyy-MM-dd').format(_date[indices]))
            == DateTime.parse(DateFormat('yyyy-MM-dd').format(_date[index]))) {
            _convert.add(_conversion[index]);
        }
      }
      if (_agendaList.containsKey(_date[indices]) == false) {
        _agendaList.addAll({
          DateTime.parse(DateFormat('yyyy-MM-dd').format(_date[indices])) : _convert
        });
        _convert = [];
      } else {
        _convert = [];
      }
    }
    return _agendaList;
  }

  int getHashCode(DateTime date) {
    return date.day * 1000000 + date.month * 10000 + date.year;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PlanDialog(
                button: 'CREATE',
                plan: PlanModel.empty(),
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
          child: FutureBuilder(
            future: getPlan(),
            builder: (context, snapshot) {
              final _agendas = LinkedHashMap<DateTime, List>(
                equals: isSameDay,
                hashCode: getHashCode
              )..addAll(_agendaList);
              List _getAgendaForDay(DateTime day) {
                return _agendas[day] ?? [];
              }
              return Column(
                children: [
                  SizedBox(height: height * 0.05),
                  Text(
                    'PLANNER',
                    style: TextStyle(
                      fontWeight: extrabold,
                      fontSize: width <= breakpoint ? headline4 * mobile : headline4
                    )
                  ),
                  SizedBox(height: height * 0.1),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: width <= breakpoint ? width * 0.15 : width * 0.20),
                    elevation: 4.0,
                    child: TableCalendar(
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: _selectedDay ?? DateTime.now(),
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      eventLoader: _getAgendaForDay,
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          _selectedDay = selectDay;
                          _focusedDay = focusDay;
                        });
                        _getAgendaForDay(selectDay);
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(_selectedDay, date);
                      },
                      calendarBuilders: CalendarBuilders(
                        markerBuilder:(context, day, event) => BuildMarker(agenda: event, width: width)),
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle
                        ),
                        todayTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryVariant,
                          shape: BoxShape.circle
                        ),
                        weekendTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontSize: width <= breakpoint ? headline6 * mobile : headline6,
                          fontWeight: semibold
                        )
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontWeight: medium,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                        weekendStyle: TextStyle(
                          fontWeight: medium,
                          color: Theme.of(context).colorScheme.onSurface
                        )
                      ),
                    )
                  ),
                  SizedBox(height: height * 0.05),
                  Text(DateFormat('E, d/M/y').format((_focusedDay!)).toString()),
                  SizedBox(height: height * 0.01),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _getAgendaForDay(_focusedDay!).map((_) =>
                      Container(
                        width: width * 0.6,
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Text('09:00'),
                            title: Text('Makan-Makan'),
                            trailing: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(Icons.edit_rounded),
                                  )
                                ),
                                SizedBox(width: width * 0.02),
                                GestureDetector(
                                  onTap: () {},
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(Icons.delete_rounded),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ).toList()
                  )
                ],
              );
            }
          ),
        ),
      )
    );
  }
}
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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<PlanModel>> _agendaList = {};
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final agendas = LinkedHashMap<DateTime, List<PlanModel>>(
      equals: isSameDay,
      hashCode: getHashCode
    )..addAll(_agendaList);
    List getAgendaForDay(DateTime day) {
      return agendas[day] ?? [];
    }
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
          child: Column(
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
                  eventLoader: getAgendaForDay,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                    });
                      getAgendaForDay(selectedDay);
                    }
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
              Text(DateFormat('E, d/M/y').format((_focusedDay)).toString()),
              SizedBox(height: height * 0.01),
              // Consumer(
              //   builder: (context, ref, child) {
              //     final planController = ref.watch(PlanController.planControllerProvider);
              //     return planController.when(
              //       data: (data) => ListView.builder(
              //         itemBuilder: (context, index) {
              //           if (data[index].tanggal == getAgendaForDay(_focusedDay)) {
              //             return Card(
              //               elevation: 2,
              //               child: ListTile(
              //                 leading: Text(DateFormat('hh:mm a').format((data[index].waktu!).toDate()).toString()),
              //                 title: Text(data[index].agenda!),
              //                 trailing: Wrap(
              //                   children: [
              //                     GestureDetector(
              //                       onTap: () {},
              //                       child: MouseRegion(
              //                         cursor: SystemMouseCursors.click,
              //                         child: Icon(Icons.edit_rounded),
              //                       )
              //                     ),
              //                     SizedBox(width: width * 0.02),
              //                     GestureDetector(
              //                       onTap: () {},
              //                       child: MouseRegion(
              //                         cursor: SystemMouseCursors.click,
              //                         child: Icon(Icons.delete_rounded),
              //                       )
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           }
              //         }
              //       ),
              //       loading: (_) => const Center(
              //         child: RefreshProgressIndicator()
              //       ),
              //       error: (error, stack, _) => Center(
              //         child: Text(error.toString())
              //       )
              //     );
              //   }
              // )
            ]
          )
        ),
      )
    );             
  }
}
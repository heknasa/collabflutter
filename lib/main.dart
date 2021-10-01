import 'package:collabflutter/custom_expansion_tile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const LoginPage(),
        '/main': (context) => const MyApp()
      }
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color todoListColor = Color(0xFF1A1A1A);
  double todoListStroke = 4.0;
  DateTime? _date;
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double figmaFont = 2/3;
    double mobileFont = 3/4;
    double mobileIcon = 4/5;
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              MouseRegion(
                onEnter: (s) {
                  setState(() {
                    todoListColor = Color(0xFFE6E6E6);
                    todoListStroke = 0.0;
                  });
                },
                onExit: (s) {
                  setState(() {
                    todoListColor = Color(0xFF1A1A1A);
                    todoListStroke = 4.0;
                  });
                },
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    // navigate
                  },
                  child: Stack(
                    children: [
                      width <= 767
                      ? // empty text instead of null
                      Text('')
                      : Text(
                        'TO DO LIST',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: width <= 767 ? 36.0 * figmaFont * mobileFont : 36.0 * figmaFont,
                            foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = todoListStroke
                                ..color = Color(0xFFE6E6E6)
                          )
                        ),
                      ),
                      Text(
                        'TO DO LIST',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: width <= 767 ? Color(0xFFE6E6E6) : todoListColor,
                            fontWeight: FontWeight.w800,
                            fontSize: width <= 767 ? 36.0 * figmaFont * mobileFont : 36.0 * figmaFont
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
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
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
                              'The Quick Brown Fox Jumps over the Lazy Dog',
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
                                  'HHH, TT/BB/TTTT | JJ:MM AM',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Color(0xFFCCCCCC),
                                      fontWeight: FontWeight.w400,
                                      fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont 
                                    )
                                  ),
                                ),
                                Text(
                                  'Kategori',
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
                        onPressed: () {},
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
                        onPressed: () {},
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
              SizedBox(height: height * 0.01),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01)),
                            backgroundColor: Color(0xFF333333),
                            child: Container(
                              margin: width <= 767 ? EdgeInsets.all(width * 0.05) : EdgeInsets.all(width * 0.02),
                              width: width * 0.3,
                              height: width <= 767 ? height * 0.6 : height * 0.7,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'ADD TO DO',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: Color(0xFFE6E6E6),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width <= 767 ? 36.0 * figmaFont * mobileFont : 36.0 * figmaFont,
                                        )
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            cursorColor: Color(0xFFCCCCCC),
                                            maxLength: 40,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'Judul',
                                              labelStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                                )
                                              ),
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
                                              counterStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont
                                                )
                                              )
                                            ),
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFFCCCCCC),
                                                fontWeight: FontWeight.w400,
                                                fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Deadline',
                                                style:  GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                    color: Color(0xFFCCCCCC),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                                  )
                                                ),
                                              ),
                                              SizedBox(height: height * 0.01),
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
                                                          fontSize: width <= 767 ? 20.0 * figmaFont * mobileFont : 20.0 * figmaFont,
                                                          fontStyle: FontStyle.italic
                                                        )
                                                      )
                                                    ),
                                                    style: ButtonStyle(
                                                      side: MaterialStateProperty.all(BorderSide(color: Color(0xFFCCCCCC), width: 1.0)),
                                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.05)))
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.02),
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
                                                        setState(() {
                                                          _time = time;
                                                        });
                                                      });
                                                    },
                                                    child: Text(
                                                      _time != null ? _time!.format(context) : 'show clock',
                                                      style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                          color: Color(0xFFCCCCCC),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: width <= 767 ? 20.0 * figmaFont * mobileFont : 20.0 * figmaFont,
                                                          fontStyle: FontStyle.italic
                                                        )
                                                      )
                                                    ),
                                                    style: ButtonStyle(
                                                      side: MaterialStateProperty.all(BorderSide(color: Color(0xFFCCCCCC), width: 1.0)),
                                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.05)))
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.02),
                                          TextField(
                                            cursorColor: Color(0xFFCCCCCC),
                                            maxLength: 20,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'Kategori',
                                              labelStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                                )
                                              ),
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
                                              counterStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont
                                                )
                                              )
                                            ),
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFFCCCCCC),
                                                fontWeight: FontWeight.w400,
                                                fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            cursorColor: Color(0xFFCCCCCC),
                                            maxLength: 200,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'Deskripsi',
                                              labelStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                                )
                                              ),
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
                                              counterStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Color(0xFFCCCCCC),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width <= 767 ? 16.0 * figmaFont * mobileFont : 16.0 * figmaFont
                                                )
                                              )
                                            ),
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFFCCCCCC),
                                                fontWeight: FontWeight.w400,
                                                fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    ElevatedButton(
                                      onPressed: () {
                                        // create to firestore
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'CREATE',
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            color: Color(0xFF333333),
                                            fontWeight: FontWeight.w800,
                                            fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont
                                          ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01))),
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
                      );
                    }
                  );
                },
                child: Icon(
                  Icons.add_rounded,
                  size: width <= 767 ? 20.0 * mobileIcon : 20.0,
                  color: Color(0xFF1A1A1A),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.01))),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFB82E2E)),
                  shadowColor: MaterialStateProperty.all(Color(0xFFB82E2E)),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) return Color(0xFFCCCCCC);
                  })
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

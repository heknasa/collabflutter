import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double figmaFont = 2/3;
    double mobileFont = 3/4;
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              TextButton(
                onPressed: () {
                  // nanti navigate
                },
                child: Text(
                  'TO DO LIST',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Color(0xFFE5E5E5),
                      fontWeight: FontWeight.w800,
                      fontSize: 36.0 * figmaFont
                    )
                  ),
                )
              ),
              SizedBox(height: height * 0.1),
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
                      child: ExpansionTile(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Color(0xFFE5E5E5),
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
                              color: Color(0xFFE5E5E5),
                              fontWeight: FontWeight.w600,
                              fontSize: width <= 767 ? 24.0 * figmaFont * mobileFont : 24.0 * figmaFont 
                            )
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HH/BB/TTTT',
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
                        trailing: Text(''),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

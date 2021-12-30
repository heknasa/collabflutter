import 'package:collabflutter/components/internship_widget.dart';
import 'package:collabflutter/components/theme_switch.dart';
import 'package:collabflutter/states/internship_control.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternshipScreen extends StatelessWidget{
  const InternshipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;    
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/home');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 40.0,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                Text(
                  'INTERNSHIP',
                  style: TextStyle(
                    fontWeight: extrabold,
                    fontSize: width <= breakpoint ? headline4 * mobile : headline4
                  )
                ),
                SizedBox(height: height * 0.1),
                SizedBox(
                  width: width * 0.6,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final internshipController = ref.watch(InternshipController.internshipControllerProvider);
                      return internshipController.when(
                        data: (data) => ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Internship(
                              internship: data[index],
                              width: width,
                              height: height
                            );
                          },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
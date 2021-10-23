// import 'package:collabflutter/providers/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'theme.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'providers/theme_provider.dart';

// class TemporaryTheme extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         return MaterialApp(
//           home: Scaffold(
//             floatingActionButton: FloatingActionButton.extended(
//               onPressed: () {
//                 ref.watch(themeMode.notifier).changeThemeMode();
//               },
//               icon: Icon(Icons.add_rounded),
//               label: Text(
//                 'CREATE',
//               )
//             ),
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(
//                 'Hello World App',
//               )
//             ),
//             body: Center(
//               child: Text(
//                 'Hello World',
//                 style: TextStyle(
//                   fontSize: Theme.of(context).textTheme.headline2!.fontSize,
//                   fontWeight: black,
//                   fontStyle: italic
//                 )
//               )
//             ),
//           ),
//           themeMode: ref.watch(themeMode),
//           theme: ref.watch(theme),
//           darkTheme: ref.watch(darkTheme),
//         );
//       }
//     );
//   }
// }
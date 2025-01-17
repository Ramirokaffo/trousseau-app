import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trousseau/ui/Home/Home.dart';

import 'Utils/themeCustom.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.themeDataLight,
      darkTheme: ThemeCustom.themeDataDark,
      // themeMode: context.watch<SettingsController>().themeMode,

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      //   useMaterial3: true,
      // ),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     useMaterial3: true,
      //     colorSchemeSeed: Colors.yellow,
      //     appBarTheme:
      //         AppBarTheme(backgroundColor: Colors.yellow.withOpacity(0.1))),
      home: const MyHomePage(),
    );
  }
}

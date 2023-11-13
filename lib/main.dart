import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz_app/Screen/quiz_screen.dart';
import 'package:quiz_app/Screen/result_screen.dart';
import 'package:quiz_app/Screen/splash_screen.dart';
import 'package:quiz_app/Screen/welcome.dart';
import 'package:quiz_app/util/binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'Flutter Quiz App',
      home: splash(),
      getPages: [
        GetPage(
          name: WelcomeScreen.routeName,
          page: () => WelcomeScreen(),
        ),
        GetPage(name: QuizScreen.routeName, page: () => QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () => ResultScreen()),
      ],
    );
  }
}

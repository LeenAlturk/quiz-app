import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:quiz_app/Screen/welcome.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 10000,
        splash: Container(
          color: Color.fromARGB(255, 7, 57, 57),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.network(
                    "https://lottie.host/4048fa94-ed6d-45f2-b091-c6620f48154f/4GSIoZ3GAy.json"),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 300.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        FadeAnimatedText('Quiz'),
                        FadeAnimatedText('Quiz your Info !!'),
                        FadeAnimatedText('Quiz your Info in football!!!'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        nextScreen: WelcomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: double.infinity,
        backgroundColor: Colors.white);
  }

  //https://lottie.host/79e77c09-b956-459c-9839-3d62b9aeffdd/BpkVlHHiDz.json
}

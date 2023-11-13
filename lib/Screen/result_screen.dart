import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constant.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/widget/custombutton.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;
  @override
  void initState() {
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 7, 57, 57),
        body: Stack(
          children: [
            Container(
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('assets/images/back.jpg'), fit: BoxFit.cover),
                // ),
                ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 0,
              maxBlastForce: 100,
              minBlastForce: 80,
              emissionFrequency: 1,
              numberOfParticles: 20,
            ),
            Center(
              child: GetBuilder<QuizController>(
                init: Get.find<QuizController>(),
                builder: (controller) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Congratulation',
                    //   style: Theme.of(context).textTheme.headline3!.copyWith(
                    //         color: Colors.white,
                    //       ),
                    // ),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 50.0,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('congratulation'),
                          WavyAnimatedText('dear user'),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      controller.name,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: KPrimaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your Score is',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${controller.scoreResult.round()} /100',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: KPrimaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          onPressed: () {
                            _confettiController.play();
                          },
                          text: 'Celebrate',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                            onPressed: () => controller.startAgain(),
                            text: 'Start Again'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

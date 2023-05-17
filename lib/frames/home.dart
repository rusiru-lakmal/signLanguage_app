// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/frames/signToTextTranslation/signToTextTranslation.dart';
import '../controller/classifier.dart';
import 'realtime.dart';
import 'realtimeAudio.dart';
import 'text2sign.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatefulWidget {
  late Classifier? classifier;
  // const Home({Key? key}) : super(key: key);
  Home({Key? key, this.classifier}) : super(key: key);
  @override
  State<Home> createState() => _HomeState(classifier: classifier);
}

class _HomeState extends State<Home> {
  late Classifier? classifier;
  List<bool> borderList = [false, false, false, true];

  _HomeState({this.classifier});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHight = size.height + AppBar().preferredSize.height;
    double containerWidth = MediaQuery.of(context).size.width;
    Color containerColor = Color.fromARGB(255, 184, 184, 184);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 184, 184),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                  width: containerWidth,
                  color: containerColor,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: containerHight * 0.4,
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        const Center(
                          child: Text(
                            "welcome!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const Center(
                          child: Text(
                            "What can \nI translate for you today",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: containerHight * 0.07,
                  width: containerWidth,
                  color: containerColor,
                  child: Container(
                    height: containerHight * 0.075,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 184, 184, 184),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              borderList[3] = true;
                              borderList[0] =
                                  borderList[1] = borderList[2] = false;
                            },
                          );
                          //sleep(Duration(milliseconds: 1000));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TextToSignLanguage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: boxDecoration(containerColor, 3),
                          child: buttonContent('assets/icons/text.png', "Text"),
                        ),
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              borderList[1] = true;
                              borderList[0] =
                                  borderList[2] = borderList[3] = false;
                            },
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RealTimeAudioTranslate(),
                            ),
                          );
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: boxDecoration(containerColor, 1),
                          child:
                              buttonContent('assets/icons/audio.png', "Audio"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              borderList[2] = true;
                              borderList[0] =
                                  borderList[1] = borderList[3] = false;
                            },
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignToTextTranslation(title: classifier),
                            ),
                          );
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: boxDecoration(containerColor, 2),
                          child:
                              buttonContent('assets/icons/image.png', "Image"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(Color color, int index) {
    return BoxDecoration(
      color: Colors.white,
      border: borderList[index]
          ? Border.all(color: color, width: 3.0)
          : Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(70),
      boxShadow: const [
        BoxShadow(
          blurStyle: BlurStyle.outer,
          blurRadius: 10,
          color: Colors.grey,
        ),
        BoxShadow(
          blurStyle: BlurStyle.inner,
          blurRadius: 15,
          color: Colors.white,
        )
      ],
    );
  }

  Widget buttonContent(String iconPath, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          // color: Colors.deepPurple[400],
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            iconPath,
            color: Colors.black,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

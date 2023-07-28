import 'dart:async';
import 'package:e_kitap/legendConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LegendScreen extends StatefulWidget {
  const LegendScreen({super.key});

  @override
  State<LegendScreen> createState() => _LegendScreenState();
}

class _LegendScreenState extends State<LegendScreen> {
  String text = "Merhaba dünya Flutter'da bir metni zamanla açığa çıkarma.";

  List<String> words = [];
  int currentWordIndex = 0;
  Timer? timer;
  bool isTimerActive = true;

  @override
  void initState() {
    super.initState();
    words = LegendConstants.legend1.split(' ');
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (isTimerActive) {
        setState(() {
          if (currentWordIndex < words.length) {
            currentWordIndex++;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  void toggleTimer() {
    setState(() {
      isTimerActive = !isTimerActive;
    });
  }

  void onWordTap(String word) {
    print("Tıklanan kelime: $word");
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      textSpans.add(
        TextSpan(
          text: word,
          style: TextStyle(
            fontSize: 24,
            color: i < currentWordIndex ? Colors.black : Colors.white,
            decoration: i < currentWordIndex
                ? TextDecoration.none
                : TextDecoration.none,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onWordTap(word);
            },
        ),
      );
      if (i < words.length - 1) {
        textSpans.add(TextSpan(text: " "));
      }
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: toggleTimer,
                child: Text(isTimerActive ? "Durdur" : "Devam Et"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentWordIndex = 0;
                  });
                  startTimer();
                },
                child: Text("Yeniden Başlat"),
              ),
            ],
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: textSpans),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

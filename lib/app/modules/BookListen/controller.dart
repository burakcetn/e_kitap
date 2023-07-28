import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/e_book.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:getx_skeleton/app/modules/BookListen/constants.dart';
import 'package:logger/logger.dart';
import 'index.dart';
import 'package:audioplayers/audioplayers.dart';

class BooklistenController extends GetxController {
  RxList<InlineSpan> words = RxList.empty();

  BooklistenController();
  AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription<Duration> positionSub;
  List<EBook> books = [];
  final state = BooklistenState();
  String currentBook = "";
  void setupAudioPlayer() {
    audioPlayer.onPlayerComplete.listen((event) {
      positionSub.cancel();
      isPlaying.value = true;
      isPlaying.update((val) {});
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.playing;
      isPlaying.update((val) {});
    });
    positionSub = audioPlayer.onPositionChanged.listen(onPositionChange);
  }

  EBook? current;
  int oldSecond = 0;
  Future<void> onPositionChange(Duration duration) async {
    if (books.isNotEmpty) {
      var seconds = duration.inMilliseconds / 1000;
      var second = seconds.toInt() * 1000;
      if (second != oldSecond) {
        var currentPosition = books
            .where((x) => second >= x.start && second <= x.end)
            .firstOrNull;
        if (current != currentPosition) {
          current = currentPosition;
          wordWrap();
        }
      }
    }
  }

  void wordWrap() async {
    for (int i = 0; i < current!.words!.length; i++) {
      var element = current!.words![i];
      words.add(TextSpan(
        text: " ${element.word} ",
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            onWordTap(element.word);
          },
      ));
      words.refresh();
      await Future.delayed(600.milliseconds);
    }
  }

  void onWordTap(String word) {
    print("Tıklanan kelime: $word");
    debugPrint(words.elementAt(words.indexOf("Geçim")) as String);
    Get.defaultDialog(
      title: word,
      content: const Center(child: Text("kelimenin anlamı")),
    );
  }

  RxBool isPlaying = false.obs;
  // tap
  void handleTap(int index) {
    Get.snackbar(
      "标题",
      "消息",
    );
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    setupAudioPlayer();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }

  void playOrPaue() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      play(currentBook, Get.context);
    }
  }

  Future<void> play(String bookName, context) async {
    currentBook = bookName;
    audioPlayer.pause();
    var jsonText = await rootBundle.loadString('assets/books/$bookName.json');
    final jsonResult = jsonDecode(jsonText);
    books = List<EBook>.from(jsonResult.map((x) => EBook.fromJson(x)));
    audioPlayer.play(AssetSource("audios/$bookName.m4a"));
  }
}

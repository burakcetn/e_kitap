import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:getx_skeleton/app/data/models/sub_title.dart';
import 'package:logger/logger.dart';
import '../../data/books.dart';
import '../../data/models/book_model.dart';
import 'index.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';

class WordModel {
  WordModel(this.wordItem, this.span, this.isHighligth);
  WidgetSpan span;
  bool isHighligth;
  Word wordItem;
}

class BooklistenController extends GetxController {
  RxList<InlineSpan> words = RxList.empty();

  BooklistenController();
  AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription<Duration> positionSub;
  final state = BooklistenState();
  BookModel? currentBook;
  List<Word> cleanWords = [];
  void setupAudioPlayer() {
    audioPlayer.onPlayerComplete.listen((event) {
      positionSub.cancel();
      isPlaying.value = true;
      isPlaying.update((val) {});
    });
    audioPlayer.onPlayerStateChanged.listen((event) async {
      isPlaying.value = event == PlayerState.playing;
      audioPlayer
          .getDuration()
          .then((value) => maxPosition.value = value?.inMilliseconds ?? 1);

      isPlaying.update((val) {});
    });
    positionSub = audioPlayer.onPositionChanged.listen(onPositionChange);
  }

  RxInt maxPosition = (0).obs;
  RxDouble currentPosition = (0.0).obs;
  RxList<WordModel> spans = RxList.empty();
  Subtitle? current;
  int oldSecond = 0;
  int index = 0;
  int oldIndex = 0;
  Future<void> onPositionChange(Duration duration) async {
    if (current != null) {
      var seconds = duration.inMilliseconds;
      currentPosition.value = seconds.toDouble();
      currentPosition.update((val) {});

      var currentPositionx =
          cleanWords.where((x) => seconds >= x.start && seconds <= x.end).first;
      wordWrap(currentPositionx);
    }
  }

  Duration parseDuration(String time) {
    if (time.contains(".")) {
      time = time.replaceAll(".", "");
    }
    if (time.contains("s")) {
      time = time.replaceAll("s", "");
    }
    double miliseconds = double.tryParse(time) ?? 0;
    if (time.length <= 3) {
      miliseconds = int.parse(time) * 1000;
    }

    return Duration(milliseconds: miliseconds.toInt());
  }

  String formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    final milliseconds =
        (duration.inMilliseconds % 1000).toString().padLeft(3, '0');
    return '${seconds}s$milliseconds';
  }

  void setText() {
    spans.clear();
    spans.refresh();

    for (var e in cleanWords) {
      spans.add(WordModel(
          e,
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: Text(e.word.trim()),
            ),
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          false));

      spans.add(WordModel(
          Word(endTime: "999999999", startTime: "9999999999", word: " "),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: Text(" "),
            ),
            style: GoogleFonts.openSans(color: Colors.black, fontSize: 15),
          ),
          false));
    }
    spans.refresh();
    update();
  }

  void wordWrap(Word currentWord) async {
    if (!isPlaying.value) return;

    for (var element in spans) {
      element.span = createSpan(element, Colors.transparent);
    }
    spans.refresh();

    var element = spans.where((x) => x.wordItem == (currentWord)).first;
    element.isHighligth = true;
    element.span = createSpan(element, Colors.amber);
    spans.refresh();
    // if (!isPlaying.value) return;
    // for (int i = 0; i < cleanWords.length; i++) {
    //   var element = cleanWords[i];
    //   if (element.word.trim().isEmpty) {
    //     continue;
    //   }
    //   var item = spans
    //       .where(
    //           (p0) => p0.word.contains(element.word) && p0.isHighligth == false)
    //       .first;
    //   spans.forEach((element) {
    //     element.span = drawSpan(element);
    //   });
    //   item.span = WidgetSpan(
    //     child: Container(
    //       color: Colors.amber,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    //         child: Text("${element.word}"),
    //       ),
    //     ),
    //     style: TextStyle(
    //       color: Colors.black,
    //       height: 1.5,
    //       fontSize: 15,
    //     ),
    //   );
    //   item.isHighligth = true;
    //   update();
    //   // if (i != (current!.words!.length - 2)) {
    //   //   await Future.delayed(600.milliseconds);
    //   // }
    // }
  }

  WidgetSpan createSpan(WordModel element, Color color) {
    return WidgetSpan(
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Text(
            element.wordItem.word.trim(),
          ),
        ),
      ),
      style: GoogleFonts.openSans(
        color: Colors.black,
        fontSize: 15,
        height: .9,
      ),
    );
  }

  WidgetSpan drawSpan(WordModel element) {
    return WidgetSpan(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Text("${element.wordItem?.word}"),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        height: 1.5,
        fontSize: 15,
      ),
    );
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
      play(currentBook!, Get.context);
    }
  }

  Future<void> play(BookModel bookName, context) async {
    if (currentBook == bookName) {
      audioPlayer.resume();
      return;
    }
    currentBook = bookName;
    audioPlayer.pause();
    var jsonText = await rootBundle.loadString(bookName.bookPath);
    final jsonResult = jsonDecode(jsonText);

    current = Subtitle.fromJson(jsonResult);

    getWords();
    audioPlayer.play(AssetSource(bookName.audioPath));
  }

  void getWords() {
    cleanWords.clear();
    current!.results.forEach((element) {
      element.alternatives.forEach((x) {
        cleanWords.addAll(x.words.toList());
      });
    });
    for (Word item in cleanWords) {
      item.start = parseDuration(item.startTime).inMilliseconds;
      item.end = parseDuration(item.endTime).inMilliseconds;
    }
    // cleanWords.sort(
    //   (a, b) {
    //     return a.start.compareTo(b.start);
    //   },
    // );
    setText();
  }
}

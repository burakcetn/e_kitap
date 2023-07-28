import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:getx_skeleton/app/components/custom_snackbar.dart';
import 'package:getx_skeleton/app/data/models/sub_title.dart';
import 'package:logger/logger.dart';
import '../../data/books.dart';
import '../../data/models/book_model.dart';
import 'constants.dart';
import 'index.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';

class WordModel {
  bool ischecked = false;

  bool? isSpell = false;

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
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: Text(e.word.trim()),
              ),
              onTap: () {
                ontapWord(e);
              },
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

  List<String> suffixes = [
    "larıdır",
    "lıkta",
    "leri",
    "ları",
    "mış",
    "miş",
    "muş",
    "müş",
    "mak",
    "mek",
    "sı",
    "si",
    "ya",
    "ler",
    "lar",
    "mı",
    "mi",
    "ları"
  ];

  void ontapWord(Word word) {
    var item = getSpell(word, nextStep: true);
    if (item != null) {
      Get.defaultDialog(
          title: item.spell,
          content: Row(
            children: [
              Text("${item.description}"),
            ],
          ));
    }
  }

  SpellMap? getSpell(Word wordkey, {bool nextStep = false}) {
    var word = wordkey.word;
    print(word);
    for (var item in suffixes) {
      if (word.contains(item)) {
        word = word.replaceAll(item, "");
      }
    }
    var spellBook = dictionaryConstants()
        .words
        .where((e) => e.bookName == currentBook!.name)
        .first;
    var item = spellBook.getSpell(word);
    for (var suff in suffixes) {
      item ??= spellBook.getSpell(word + suff);
      if (item != null) break;
    }
    if (item == null) {
      if (word.toLowerCase().contains("olur")) {
        item ??= spellBook.getSpell("olmak");
      }
    }
    if (!nextStep && item != null && item.spell.split(" ").length > 1) {
      int index = cleanWords.indexOf(wordkey);
      int nextIndex = index + 1;
      int prevIndex = index - 1;

      var nextWord = cleanWords[nextIndex];
      var nextSpell = getSpell(nextWord, nextStep: true);
      if (nextSpell != null && item.spell == nextSpell.spell) {
        return item;
      }

      var prevWord = cleanWords[prevIndex];
      var prevSpell = getSpell(prevWord, nextStep: true);
      if (prevSpell != null && item.spell == prevSpell.spell) {
        return item;
      }

      return null;
    }
    return item;
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
  }

  WidgetSpan createSpan(WordModel element, Color color) {
    if (!element.ischecked) {
      element.isSpell = getSpell(element.wordItem) != null;
    }
    element.ischecked = true;
    return WidgetSpan(
      child: GestureDetector(
        onTap: () {
          ontapWord(element.wordItem);
        },
        child: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Text(
              element.wordItem.word.trim(),
            ),
          ),
        ),
      ),
      style: GoogleFonts.openSans(
          color: Colors.black,
          fontSize: 15,
          height: .9,
          decoration:
              (element.isSpell ?? false) ? TextDecoration.underline : null),
    );
  }

  WidgetSpan drawSpan(WordModel element) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () {
          ontapWord(element.wordItem);
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Text(element.wordItem.word),
          ),
        ),
      ),
      style: TextStyle(
          color: Colors.black,
          height: 1.5,
          fontSize: 15,
          decoration: getSpell(element.wordItem) == null
              ? null
              : TextDecoration.underline),
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

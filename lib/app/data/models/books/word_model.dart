import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../../../modules/BookListen/constants.dart';
import '../book_model.dart';
import '../sub_title.dart';

class WordModel {
  bool ischecked = false;

  bool? isSpell = false;

  WordModel(this.wordItem, this.span, this.isHighligth);
  InlineSpan span;
  bool isHighligth;
  Word wordItem;
}

class BookManager {
  BookManager(this.book);
  final BookModel book;
  Subtitle? current;
  Future<void> load() async {
    try {
      Logger().i(book.name);
      var jsonText = await rootBundle.loadString(book.bookPath);
      final jsonResult = jsonDecode(jsonText);
      current = Subtitle.fromJson(jsonResult);
      getWords();
      wordWrap(0, audioPlayer);
    } catch (e) {
      Logger().d(e);
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

  List<Word> cleanWords = [];
  RxList<WordModel> spans = RxList.empty();

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
    setText();
  }

  Future<void> ontapWord(Word word) async {
    var item = getSpell(word, nextStep: true);
    if (item != null) {
      audioPlayer.pause();
      await Get.defaultDialog(
        title: item.spell,
        content: Row(
          children: [
            Text("${item.description}"),
          ],
        ),
      );
      audioPlayer.resume();
    }
  }

  void setText() {
    spans.clear();
    spans.refresh();
    bool beforeLarge = false;
    for (var e in cleanWords) {
      if (e.large == false && beforeLarge) {
        spans.add(
          WordModel(
              Word(startTime: "-1", endTime: "-1", word: "\n", large: false),
              TextSpan(
                text: "\n",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              false),
        );
      }

      spans.add(
        WordModel(
            e,
            WidgetSpan(
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  child: Text(e.word.trim(),
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: e.large ? 20 : 15,
                          fontWeight:
                              e.large ? FontWeight.bold : FontWeight.normal)),
                ),
                onTap: () {
                  ontapWord(e);
                },
              ),
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: e.large ? 20 : 15,
                  fontWeight: e.large ? FontWeight.bold : FontWeight.normal),
            ),
            false),
      );

      if (e.large == false && !beforeLarge) {
        spans.add(WordModel(
            Word(
                endTime: "999999999",
                startTime: "9999999999",
                word: " ",
                large: false),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: Text(" "),
              ),
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 15),
            ),
            false));
      }

      beforeLarge = e.large;
    }
    spans.refresh();
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

  SpellMap? getSpell(Word wordkey, {bool nextStep = false}) {
    var word = wordkey.word;
    for (var item in suffixes) {
      if (word.contains(item)) {
        word = word.replaceAll(item, "");
      }
    }
    var spellBook = dictionaryConstants()
        .words
        .where((e) => e.bookName == book.name)
        .firstOrNull;
    if (spellBook == null) return null;
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
    if (item == null) {
      if (word.toLowerCase().contains("olmaz")) {
        item ??= spellBook.getSpell("olma");
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

  late AudioPlayer audioPlayer;
  void wordWrap(int seconds, AudioPlayer audioPlayer) async {
    this.audioPlayer = audioPlayer;
    var currentPositionx = cleanWords
        .where((x) => seconds >= x.start && seconds <= x.end)
        .firstOrNull;
    if (currentPositionx == null) return;
    for (var element in spans) {
      element.span = createSpan(element, Colors.transparent);
    }
    spans.refresh();

    var element = spans.where((x) => x.wordItem == (currentPositionx)).first;
    element.isHighligth = true;
    element.span =
        createSpan(element, seconds == 0 ? Colors.transparent : Colors.amber);
    spans.refresh();
  }

  bool beforeLarge = false;

  InlineSpan createSpan(WordModel element, Color color) {
    if (!element.ischecked) {
      element.isSpell = getSpell(element.wordItem) != null;
    }
    element.ischecked = true;

    if (element.wordItem.large == false && beforeLarge) {
      beforeLarge = element.wordItem.large;
      return TextSpan(
        text: "\n",
        style: GoogleFonts.openSans(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      );
    }

    beforeLarge = element.wordItem.large;
    return WidgetSpan(
      child: GestureDetector(
        onTap: () {
          ontapWord(element.wordItem);
        },
        child: Container(
          color: color,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2, vertical: element.wordItem.large ? 10 : 2),
            child: Text(
              element.wordItem.word.trim(),
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: element.wordItem.large ? 20 : 15,
                fontWeight: element.wordItem.large
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
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

  String getName() {
    return book.name;
  }

  String getImage() {
    return book.imagePath;
  }
}

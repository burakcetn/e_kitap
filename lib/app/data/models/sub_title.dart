// To parse this JSON data, do
//
//     final subtitle = subtitleFromJson(jsonString);

import 'dart:convert';

Subtitle subtitleFromJson(String str) => Subtitle.fromJson(json.decode(str));

String subtitleToJson(Subtitle data) => json.encode(data.toJson());

class Subtitle {
  List<Result> results;

  Subtitle({
    required this.results,
  });

  factory Subtitle.fromJson(Map<String, dynamic> json) => Subtitle(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  List<Alternative> alternatives;
  String resultEndTime;
  String languageCode;

  Result({
    required this.alternatives,
    required this.resultEndTime,
    required this.languageCode,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        alternatives: List<Alternative>.from(
            json["alternatives"].map((x) => Alternative.fromJson(x))),
        resultEndTime: json["resultEndTime"],
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toJson() => {
        "alternatives": List<dynamic>.from(alternatives.map((x) => x.toJson())),
        "resultEndTime": resultEndTime,
        "languageCode": languageCode,
      };
}

class Alternative {
  String transcript;
  double confidence;
  List<Word> words;

  Alternative({
    required this.transcript,
    required this.confidence,
    required this.words,
  });

  factory Alternative.fromJson(Map<String, dynamic> json) => Alternative(
        transcript: json["transcript"],
        confidence: json["confidence"].toDouble(),
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transcript": transcript,
        "confidence": confidence,
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
      };
}

class Word {
  String startTime;
  String endTime;
  String word;
  int start = 0;
  bool isOk = false;
  int end = 0;
  Word({
    required this.startTime,
    required this.endTime,
    required this.word,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        startTime: json["startTime"],
        endTime: json["endTime"],
        word: json["word"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
        "word": word,
      };
}

class EBook {
  late int start;
  late int end;
  late String part;
  late List<Words>? words;

  EBook(
      {required this.start, required this.end, required this.part, this.words});

  EBook.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    part = json['part'];
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(new Words.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    data['part'] = this.part;
    if (this.words != null) {
      data['words'] = this.words!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Words {
  late String word;

  Words({required this.word});

  Words.fromJson(Map<String, dynamic> json) {
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    return data;
  }
}

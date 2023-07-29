class QuestionModel {
  List<QuestionWrapModel> questions = [];
  String title;
  String quizKey = "";
  QuestionModel(this.title, this.quizKey);
  int nextOrder = 1;
  void add(QuestionWrapModel question) {
    question.order = nextOrder;
    nextOrder++;
    questions.add(question);
  }

  void clear() {
    for (var item in questions) {
      item.isOkey = false;
    }
  }
}

class QuestionWrapModel {
  String question;
  String value;
  bool isOkey = false;
  int order = 0;
  QuestionWrapModel(this.question, this.value);
}

class QuestionManager {
  static QuestionManager instance = QuestionManager();

  QuestionManager() {
    load();
  }
  List<QuestionModel> quiz = [];
  void load() {
    QuestionModel model = QuestionModel(
        "Aşağıdaki kelimeleri anlam ve bağlamına uygun olarak cümlelere yerleştiriniz.",
        "quiz1");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
        "Ülkedeki kömür {answer} yöre halkı çalışmaktadır",
        "havzasında",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Yağmurla birlikte sanki sel değil de {answer} oldu. Yer yerinden oynadı",
        "tufan",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Kadın her gün birbirinden daha da yorucu olan hayatına {answer}.",
        "isyan etti",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Ne yapacağını bilemeyen çocuk, korkulu gözlerle bakan annesine {answer}.",
        "sığındı",
      ),
    );
    model.add(
      QuestionWrapModel(
        "Mahallenin çocukları kendileri gibi olmayan bu çocukla sürekli {answer}.",
        "alay ediyordu",
      ),
    );
    model = QuestionModel("selam kanka", "quz2");
    quiz.add(model);
    model.add(
      QuestionWrapModel(
        "Ülkedeki kömür {answer} yöre halkı çalışmaktadır",
        "havzasında",
      ),
    );
  }
}

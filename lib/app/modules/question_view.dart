import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/books/word_model.dart';
import '../data/models/question/question_model.dart';

class QuestionView extends StatelessWidget {
  const QuestionView(this.model, {Key? key}) : super(key: key);
  final BookManager model;
  @override
  Widget build(BuildContext context) {
    List<QuestionModel> quizList =
        QuestionManager.instance.getQuiz(model.book.question);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(model.getName()),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: quizList.length,
          itemBuilder: ((context, index) {
            var model = quizList[index];
            var type2Values = model.questions.map((e) => e).toList();
            type2Values.shuffle();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                if (model.type == 0)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " Aşağıdaki kelimeleri anlam ve bağlamına uygun olarak cümlelere yerleştiriniz.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                if (model.type == 1)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " Aşağıdaki kelimeleri eş anlamlıları ile eşleştiriniz",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: model.questions
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Draggable(
                                data: e,
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(child: Text(e.value)),
                                ),
                                feedback: Material(
                                  child: Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.amber,
                                    ),
                                    child: Center(child: Text(e.value)),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...model.questions.map((e) => drawQuestion(e)).toList(),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget drawQuestion(QuestionWrapModel item) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 20),
      child: Wrap(
        children: [
          Text(
            "${item.order.toString()}. ",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          item.type == 0
              ? Wrap(
                  children: item.question.split(" ").map(
                    (e) {
                      if (e == "{answer}" || e == "{answer}.") {
                        return DragTarget<QuestionWrapModel>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return Container(
                              color: Colors.white,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  width: 100,
                                  color: item.isOkey ? Colors.green : null,
                                  child: Center(
                                      child: Text(
                                    !item.isOkey
                                        ? "................."
                                        : '${item.value}',
                                    //textScaleFactor: 2,
                                  )),
                                ),
                              ),
                            );
                          },
                          onAccept: (data) {
                            debugPrint('hi $data');
                            //Get.snackbar('Tebrikler', "");
                            item.isOkey = true;
                          },
                          onWillAccept: (data) {
                            return item.value == data?.value;
                          },
                          onLeave: (data) {
                            // Get.snackbar("Tekrar dene!", "");
                          },
                        );
                      } else {
                        return Container(
                          height: 20,
                          child: Text(
                            " $e ",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        );
                      }
                    },
                  ).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: item.question.split("~~").map(
                    (e) {
                      if (e == "{answer}" || e == "{answer}.") {
                        return DragTarget<QuestionWrapModel>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return Container(
                              color: Colors.white,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  width: 200,
                                  color: item.isOkey ? Colors.green : null,
                                  child: Center(
                                      child: Text(
                                    !item.isOkey
                                        ? ".............................................................."
                                        : '${item.value}',
                                    //textScaleFactor: 2,
                                  )),
                                ),
                              ),
                            );
                          },
                          onAccept: (data) {
                            debugPrint('hi $data');
                            //Get.snackbar('Tebrikler', "");
                            item.isOkey = true;
                          },
                          onWillAccept: (data) {
                            return item.value == data?.value;
                          },
                          onLeave: (data) {
                            // Get.snackbar("Tekrar dene!", "");
                          },
                        );
                      } else {
                        return Container(
                          height: 20,
                          child: Text(
                            " $e ",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        );
                      }
                    },
                  ).toList(),
                )
        ],
      ),
    );
  }
}

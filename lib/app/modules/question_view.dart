import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models/books/word_model.dart';
import '../data/models/question/question_model.dart';

class QuestionView extends StatefulWidget {
  const QuestionView(this.model, {Key? key}) : super(key: key);
  final BookManager model;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    List<QuestionModel> quizList =
        QuestionManager.instance.getQuiz(widget.model.book.question);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "${widget.model.getName()} Alıştırmaları",
          style: GoogleFonts.openSans(fontSize: 16),
        ),
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
                      children: model.questions.map(
                        (e) {
                          var len = e.value.length;
                          if (len < 7) len = 7;
                          return Draggable(
                            data: e,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  width: len * 10,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: e.isOkey
                                        ? Colors.green
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                      child: Text(e.value,
                                          style: GoogleFonts.openSans(
                                              color: e.isOkey
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500)
                                          //textScaleFactor: 2,
                                          )),
                                ),
                              ),
                            ),
                            feedback: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Container(
                                      width: len * 10,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: e.isOkey
                                            ? Colors.green
                                            : Colors.grey.shade200,
                                      ),
                                      child: Center(
                                          child: Text(e.value,
                                              style: GoogleFonts.openSans(
                                                  color: e.isOkey
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500)
                                              //textScaleFactor: 2,
                                              )),
                                    ),
                                  ),
                                )),
                          );
                        },
                      ).toList()),
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
          item.type == 0
              ? Wrap(
                  spacing: 4,
                  children: [
                    Container(
                      height: 30,
                      width: 2 * 10,
                      alignment: Alignment.center,
                      child: Text(
                        "${item.order.toString()}.",
                        style:
                            GoogleFonts.openSans(fontWeight: FontWeight.bold),
                        //textScaleFactor: 2,
                      ),
                    ),
                    ...item.question.split(" ").map(
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
                                    width: ((!item.isOkey
                                                    ? "---------"
                                                    : item.value)
                                                .trim())
                                            .length *
                                        10,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: item.isOkey
                                          ? Colors.green
                                          : Colors.grey.shade200,
                                    ),
                                    child: Center(
                                        child: Text(
                                      !item.isOkey
                                          ? "---------"
                                          : '${item.value}',
                                      style: GoogleFonts.openSans(
                                          color: item.isOkey
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w500),
                                      //textScaleFactor: 2,
                                    )),
                                  ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              setState(() {});
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
                            height: 30,
                            width: e.length * 9.50,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.trim(),
                              style: GoogleFonts.openSans(),
                              //textScaleFactor: 2,
                            ),
                          );
                        }
                      },
                    ).toList()
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 2 * 10,
                      child: Text(
                        "${item.order.toString()}.",
                        style:
                            GoogleFonts.openSans(fontWeight: FontWeight.bold),
                        //textScaleFactor: 2,
                      ),
                    ),
                    ...item.question.split("~~").map(
                      (e) {
                        if (e == "{answer}" || e == "{answer}.") {
                          return DragTarget<QuestionWrapModel>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              var len =
                                  ((!item.isOkey ? "---------" : item.value)
                                          .trim())
                                      .length;
                              if (len < 9) len = 10;
                              return Container(
                                color: Colors.white,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    width: len * 9,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: item.isOkey
                                          ? Colors.green
                                          : Colors.grey.shade200,
                                    ),
                                    child: Center(
                                        child: Text(
                                            !item.isOkey
                                                ? "---------"
                                                : '${item.value}',
                                            style: GoogleFonts.openSans(
                                                color: item.isOkey
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500)
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
                              setState(() {});
                            },
                            onWillAccept: (data) {
                              return item.value == data?.value;
                            },
                            onLeave: (data) {
                              // Get.snackbar("Tekrar dene!", "");
                            },
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              color: Colors.white,
                              child: ClipRRect(
                                child: Container(
                                  width: "---------".length * 10,
                                  height: 30,
                                  child: Text(
                                    e.trim(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.openSans(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ).toList()
                  ],
                )
        ],
      ),
    );
  }
}

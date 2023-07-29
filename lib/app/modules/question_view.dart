import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../data/models/question/question_model.dart';

class QuestionView extends StatelessWidget {
  const QuestionView(this.model, {Key? key}) : super(key: key);
  final QuestionModel model;
  @override
  Widget build(BuildContext context) {
    model.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(model.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " Aşağıdaki kelimeleri anlam ve bağlamına uygun olarak cümlelere yerleştiriniz.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 100,
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
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...model.questions.map((e) => drawQuestion(e)).toList(),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: -2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  "Devam Et",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
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
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
          ).toList()
        ],
      ),
    );
  }
}

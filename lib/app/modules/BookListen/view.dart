import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:squiggly_slider/slider.dart';

import '../../data/books.dart';
import '../../data/models/book_model.dart';
import '../../data/models/books/word_model.dart';
import '../../data/models/question/question_model.dart';
import '../question_view.dart';
import 'index.dart';

class BooklistenPage extends GetView<BooklistenController> {
  const BooklistenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookManager book = Get.arguments as BookManager;
    controller.setBook(book);

    return GetBuilder<BooklistenController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            controller.stop();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.deepPurpleAccent,
                title: Row(
                  children: [
                    Expanded(child: Text(book.getName())),
                    IconButton(
                      onPressed: () => Get.to(
                        QuestionView(QuestionManager.instance.quiz.last),
                      ),
                      icon: Icon(Icons.question_mark_outlined),
                    ),
                  ],
                )),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ListView(
                        children: [
                          Obx(
                            () => RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children:
                                    book.spans.map((e) => e.span).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 40,
              child: Row(
                children: [
                  Obx(
                    () => IconButton(
                      icon: Icon(controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        controller.playOrPaue();
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: Obx(() => SquigglySlider(
                  //         value: controller.currentPosition.value,
                  //         min: 0,
                  //         max: controller.maxPosition.value.toDouble(),
                  //         squiggleAmplitude: controller.isPlaying.value ? 3 : 0,
                  //         squiggleWavelength: 5,
                  //         squiggleSpeed: 0.2,
                  //         label: 'Amplitude',
                  //         onChanged: (double value) {},
                  //       )),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

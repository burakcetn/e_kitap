import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:squiggly_slider/slider.dart';

import '../../data/books.dart';
import '../../data/models/book_model.dart';
import 'index.dart';

class BooklistenPage extends GetView<BooklistenController> {
  const BooklistenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooklistenController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
              title: IconButton(
                  onPressed: () => controller.showQuizDialogPamukkale(),
                  icon: Icon(Icons.question_mark_outlined))),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ListView(
                      children: [
                        Container(
                          height: 80,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<BookModel>(
                              items: bookList
                                  .map((item) => DropdownMenuItem<BookModel>(
                                        value: item,
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              isExpanded: true,
                              onChanged: (BookModel? value) {
                                if (value == null) return;
                                controller.play(value, context);
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children:
                                  controller.spans.map((e) => e.span).toList(),
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
                Expanded(
                  child: Obx(() => SquigglySlider(
                        value: controller.currentPosition.value,
                        min: 0,
                        max: controller.maxPosition.value.toDouble(),
                        squiggleAmplitude: controller.isPlaying.value ? 3 : 0,
                        squiggleWavelength: 5,
                        squiggleSpeed: 0.2,
                        label: 'Amplitude',
                        onChanged: (double value) {},
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

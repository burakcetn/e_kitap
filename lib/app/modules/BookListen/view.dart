import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../data/books.dart';
import 'index.dart';

class BooklistenPage extends GetView<BooklistenController> {
  const BooklistenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooklistenController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("")),
          body: SafeArea(
            child: ListView(
              children: [
                Container(
                  height: 80,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: booksAll
                          .map((item) => DropdownMenuItem<String>(
                                value: item["path"].toString(),
                                child: Text(
                                  item["path"].toString(),
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
                      onChanged: (String? value) {
                        if (value == null) return;
                        controller.play(value, context);
                      },
                    ),
                  ),
                ),
                Row(
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
                  ],
                ),
                Obx(
                  () => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: controller.textall.value,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: controller.text.value,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

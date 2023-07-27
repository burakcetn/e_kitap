import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class BooklistenPage extends GetView<BooklistenController> {
  const BooklistenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooklistenController>(
      builder: (_) {
        controller.play("sahmeran", context);
        return Scaffold(
          appBar: AppBar(title: const Text("booklisten")),
          body: SafeArea(
            child: ListView(
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
                Obx(
                  () => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: controller.words
                            .map((element) => element)
                            .toList()),
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

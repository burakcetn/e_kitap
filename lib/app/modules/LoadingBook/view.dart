import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/book_service.dart';
import 'index.dart';
import 'widgets/widgets.dart';

class LoadingbookPage extends GetView<LoadingbookController> {
  const LoadingbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookService.instance.init();
    return GetBuilder<LoadingbookController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("loadingbook")),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Obx(
                    () => Image.asset(
                      BookService.instance.currentImage.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            "${BookService.instance.current.value}/100",
                          ),
                        ),
                        SizedBox(),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

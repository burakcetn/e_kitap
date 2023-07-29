import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:getx_skeleton/app/services/book_service.dart';

import '../../data/books.dart';
import '../../data/models/books/word_model.dart';
import 'index.dart';

class LandingPagePage extends GetView<LandingPageController> {
  const LandingPagePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return GridView.builder(
        itemCount: BookService.instance.getLength(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          var book = BookService.instance.get(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              //TODO: routing

              onTap: () {
                Get.toNamed(Routes.PLAYER, arguments: book);
              },
              child: Container(
                decoration: BoxDecoration(
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
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(book.getImage()), fit: BoxFit.fill)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 72,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        child: Center(
                          child: Text(
                            book.getName(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dil Uygulaması"),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}

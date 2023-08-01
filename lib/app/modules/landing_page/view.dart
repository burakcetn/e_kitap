import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:getx_skeleton/app/services/book_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:turkish/turkish.dart';
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
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                            book.getName().toUpperCaseTr(),
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.deepPurpleAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.CONTACT);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "İletişim",
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: .5,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.white30),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Hikayeler",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                    ...BookService.instance.managers.map((book) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PLAYER, arguments: book);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 12, top: 12, left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      book.getName().toUpperCaseTr(),
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.white30),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: Text(
                "SesliBiDil: Türkçe Öğren",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  letterSpacing: .5,
                ),
              ),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            body: _buildView(),
          ),
        );
      },
    );
  }
}

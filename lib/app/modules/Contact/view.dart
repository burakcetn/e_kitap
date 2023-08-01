import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("İletişim"),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            backgroundColor: Colors.deepPurpleAccent,
            body: Container(
              height: Get.height,
              child: Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                          ),
                          Divider(color: Colors.white30),
                          ListTile(
                            title: Text(
                              "ORCİD: 0000-0003-2887-3607",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    "https://orcid.org/0000-0003-2887-3607"),
                              );
                            },
                            child: ListTile(
                              title: Center(
                                  child: Row(
                                children: [
                                  Text(
                                    "Orcid Profilim",
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                            ),
                          ),
                          Divider(color: Colors.white30),
                          ListTile(
                            title: Text(
                              "Mail: nurhilal.ayhan@gmail.com",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(
                                Uri.parse("mailto:nurhilal.ayhan@gmail.com"),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: ListTile(
                              title: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      "Mail gönderin",
                                      style: GoogleFonts.openSans(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

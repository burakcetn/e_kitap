import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class LandingPagePage extends GetView<LandingPageController> {
  const LandingPagePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                //TODO: routing

                onTap: () {},
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
                          image: AssetImage("assets/images/placeholder.png"),
                          fit: BoxFit.fill)),
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
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text("Efsane İsmi"),
                          ),
                        )
                      ]),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dil Uygulaması"),
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}

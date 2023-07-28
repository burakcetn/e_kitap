import 'package:e_kitap/color_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.base20,
      appBar: AppBar(
        title: const Text("Efsanelerle Öğren"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20),
                itemBuilder: (context, itemNumber) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/efsane.png")),
                        borderRadius: BorderRadius.circular(15),
                        color: ColorManager.base00,
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.shadowColor.withOpacity(0.3),
                              blurRadius: 10),
                          BoxShadow(
                            color: ColorManager.shadowColor.withOpacity(0.3),
                            spreadRadius: -2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 80,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: ColorManager.base20.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Efsane İsmi",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            )
                          ]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

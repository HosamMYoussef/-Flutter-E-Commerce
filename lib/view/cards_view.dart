import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../widgets/custom_text.dart';

class CardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Cards',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset('assets/images/card.json',
                    width: 400,
                    height: 400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "You Didn't Add Any Card Yet... ",
                    fontSize: 26,
                    alignment: Alignment.topCenter,
                  )
                ],
              )
            ),
          
        ],
      ),
    );
  }
}

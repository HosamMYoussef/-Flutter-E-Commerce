import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../widgets/custom_text.dart';

class NotificationsView extends StatelessWidget {
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
                    text: 'Notifications',
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
          SizedBox(height: 50,),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Image.asset('assets/images/cat.gif'),
                  SizedBox(
                    height: 40,
                  ),
                  CustomText(
                    text: "No New Notifications... ",
                    fontSize: 28,
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

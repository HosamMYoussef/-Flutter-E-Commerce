import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../widgets/custom_text.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          height: 400,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color.fromRGBO(131, 217, 226, 1),
                // Color.fromRGBO(162, 230, 209, 1),
                Color.fromRGBO(12, 116, 117, 1),
                Color.fromRGBO(14, 174, 87, 1),
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
                child: Text(
              'notifications',
              style: TextStyle(
                  fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
            )),
          ),
        ),
      ),
      body: Column(children: [
        Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * .06,
            // one dev to role the all

            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color.fromRGBO(131, 217, 226, 1),
                  // Color.fromRGBO(162, 230, 209, 1),
                  Color.fromRGBO(12, 116, 117, 1),
                  Color.fromRGBO(14, 174, 87, 1),
                ],
              ),
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 35,
                  )))
        ]),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/cat.gif'),
            const SizedBox(
              height: 40,
            ),
            CustomText(
              text: "No new notifications... ",
              fontFamily: 'Baumans',
              fontSize: 25,
              alignment: Alignment.topCenter,
            )
          ],
        )),
      ]),
    );
  }
}

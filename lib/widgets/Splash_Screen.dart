import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/control_view.dart';

import '../core/viewmodel/control_view_model.dart';
import '../core/viewmodel/home_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
// one dev to role the all

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    Get.put(ControlViewModel());

    return

        // GetBuilder<HomeViewModel>(
        //     init: Get.find<HomeViewModel>(),
        //     builder: (controller) => controller.isloading
        //         ?

        Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 100,
          ),
          
          Image.asset(
            'assets/images/23.png',
            width: 300,
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'one shop to rule them all',
            style: TextStyle(
              fontFamily: "Baumans",
              fontSize: 30,
              color: Color.fromARGB(255, 4, 52, 92),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const SpinKitFadingCube(
            color: Color.fromARGB(255, 11, 73, 124),
            size: 30.0,
          ),
        ]),
      ),
    );
    // :

    // ControlView());
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/checkoutview_model.dart';
import 'package:myshopp/core/viewmodel/home_view_model.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/home_view.dart';
import 'package:myshopp/widgets/custom_text.dart';
import 'package:page_transition/page_transition.dart';
import 'core/viewmodel/cart_view_model.dart';
import 'firebase_options.dart';
import 'helper/binding.dart';

//import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(CartViewModel());
  //Get.put(CheckoutViewModel());

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final HomeViewModel controller = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      themeMode: ThemeMode.dark,
      
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: ControlView(),
      // home: AnimatedSplashScreen(
        
      //   duration: 2000,
      //   splashTransition: SplashTransition.decoratedBoxTransition,
      //   splashIconSize: 800
      //   ,
        
      //   splash:Lottie.asset('assets/images/open.json', ),
      //   nextScreen:  ControlView(),
      //   //backgroundColor: primaryColor,
      //   pageTransitionType: PageTransitionType.bottomToTop ,
      //   animationDuration: Duration(seconds: 2),
      //   //backgroundColor: Colors.greenAccent
      // ),
      theme: ThemeData(
        canvasColor: Colors.white,
        fontFamily: 'OpenSans',
        backgroundColor: Colors.grey.shade100
      ),
    );
  }
}
// enum PageTransitionType {
//   fade,
//   rightToLeft,
//   leftToRight,
//   upToDown,
//   downToUp,
//   scale,
//   rotate,
//   size,
//   rightToLeftWithFade,
//   leftToRightWithFade,
// }
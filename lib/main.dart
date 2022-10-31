import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/view/review_view.dart';
import 'package:myshopp/widgets/Splash_Screen.dart';

import 'core/viewmodel/cart_view_model.dart';
import 'core/viewmodel/home_view_model.dart';
import 'firebase_options.dart';
import 'helper/binding.dart';
import 'helper/local_storage_data.dart';

//import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  Get.put(LocalStorageUser());
  Get.put(CartViewModel());
  Get.put(HomeViewModel());
  Get.put(ControlView());
  Get.put(AuthViewModel());
  Get.find<AuthViewModel>();

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
      // home: FutureBuilder(
      //   future: Get.find<HomeViewModel>().getProductsFromFireStore(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const SplashScreen();
      //     } else if (snapshot.error != null) {
      //       // handel errors
      //       return const Center(
      //         child: Text('An error ocurred '),
      //       );
      //     } else {
      //       return ControlView();
      //     }
      //   },
      // ),
      // home: SplashScreen(),
      //  home: AnimatedSplashScreen(

      //     duration: 1500,
      //     splashTransition: SplashTransition.fadeTransition,
      //     splashIconSize: 300,

      //     splash:Image.asset('assets/images/23.png', ),
      //     nextScreen:  ControlView(),
      //     //backgroundColor: primaryColor,
      //     pageTransitionType: PageTransitionType.bottomToTop ,
      //     animationDuration: Duration(milliseconds:1500 ),
      //     backgroundColor: Colors.white
      //   ),
      theme: ThemeData(
          canvasColor: Colors.white,
          fontFamily: 'OpenSans',
          backgroundColor: Colors.grey.shade100),
      //     routes: {
      //   '/': (ctx) => ControlView(),

      //   ProductDetailView.routeName: (ctx) => ProductDetailView(),
      // },
    );
  }
}

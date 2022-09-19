import 'package:flutter/services.dart';
import 'package:myshopp/core/viewmodel/checkoutview_model.dart';
import 'package:myshopp/core/viewmodel/home_view_model.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/control_view.dart';
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
      home: Scaffold(
        body: ControlView(),
        //bottomNavigationBar: curvedNavigationBar(),
      ),
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
    );
  }
}

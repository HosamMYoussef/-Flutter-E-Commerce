import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/home_view.dart';
import 'package:myshopp/view/profile_view.dart';

import '../core/viewmodel/control_view_model.dart';
import '../widgets/custom_text.dart';
import 'cart_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginView()
          : GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
              builder: (controller) => Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: curvedNavigationBar(),
              ),
            );
    });
  }
}

Widget bottomNavigationBar() {
  return SizedBox(
    height: 84,
    child: GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              activeIcon: CustomText(
                text: "Explore",
                fontSize: 14,
                alignment: Alignment.center,
              ),
              label: "",
              icon: Image.asset(
                'assets/images/Icon_Explore.png',
                fit: BoxFit.contain,
                width: 20,
                height: 20,
              )),
          BottomNavigationBarItem(
              activeIcon: CustomText(
                text: "Cart",
                fontSize: 14,
                alignment: Alignment.center,
              ),
              label: "",
              icon: Image.asset(
                'assets/images/Icon_Cart.png',
                fit: BoxFit.contain,
                width: 20,
                height: 20,
              )),
          BottomNavigationBarItem(
              activeIcon: CustomText(
                text: "Account",
                fontSize: 14,
                alignment: Alignment.center,
              ),
              label: "",
              icon: Image.asset(
                'assets/images/Icon_User.png',
                fit: BoxFit.contain,
                width: 20,
                height: 20,
              )),
          BottomNavigationBarItem(
            activeIcon: CustomText(
              text: "Sign Out",
              fontSize: 14,
              alignment: Alignment.center,
            ),
            label: "",
            icon: Container(
              child: Image.asset(
                'assets/images/signout.png',
                fit: BoxFit.contain,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
        currentIndex: controller.navigatorvalue,
        onTap: (index) {
          print(index);
          controller.changeSelectedvalue(index);
        },
        selectedItemColor: Colors.black,
      ),
    ),
  );
}

Widget curvedNavigationBar() {
  return SizedBox(
    height: 84,
    child: GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.grey.shade100,
        animationDuration: Duration(milliseconds: 500),
        buttonBackgroundColor:Colors.grey.shade100,
height: 60,
        items: [
          Icon(
            Icons.home_rounded,
            color: Color.fromRGBO(60, 183, 105, 1),
             size: 30,
             
          ),
          Icon(
            Icons.shopping_cart_rounded,
            color: Color.fromRGBO(60, 183, 105, 1),
            size: 30,
            
          ),
          Icon(
            Icons.manage_accounts,
            size: 30,
            color: Color.fromRGBO(60, 183, 105, 1),
             
            
          ),
         
          
        ],
        
        onTap: (index) {
          print(index);
          controller.changeSelectedvalue(index);
        },
        
      ),
    ),
  );
}

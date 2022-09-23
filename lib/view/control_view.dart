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
                bottomNavigationBar: bottomNavigationBar(),
              ),
            );
    });
  }
}

Widget bottomNavigationBar() {
  return GetBuilder<ControlViewModel>(
    init: ControlViewModel(),
    builder: (controller) => BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home_outlined,size: 30),
          activeIcon: Icon(Icons.home,size: 30,),
          
        ),
        BottomNavigationBarItem(
          label: "Cart",
          icon: Icon(Icons.shopping_bag_outlined,size: 30,),
          activeIcon: Icon(Icons.shopping_bag_rounded,size: 30,),
        ),
        BottomNavigationBarItem(
          label: "Favorites",
          icon: Icon(Icons.star_border,size: 30,),
          activeIcon: Icon(Icons.star,size: 30,),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person_outline,size: 30,),
          activeIcon: Icon(Icons.person,size: 30,),
        ),
      ],
      currentIndex: controller.navigatorvalue,
      onTap: (index) {
        print(index);
        controller.changeSelectedvalue(index);
      },
      selectedItemColor: Colors.black,
      // unselectedItemColor: Color.fromRGBO(60, 183, 105, 1),
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
        buttonBackgroundColor: Colors.grey.shade100,
        height: 60,
        items: [
          Icon(
            Icons.home_outlined,
            color: Color.fromRGBO(60, 183, 105, 1),
            size: 30,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            color: Color.fromRGBO(60, 183, 105, 1),
            size: 30,
          ),
          Icon(
            Icons.manage_accounts_outlined,
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

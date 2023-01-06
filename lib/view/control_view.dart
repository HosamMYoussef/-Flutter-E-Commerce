import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/view/admin/Adminhomepage.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/home_view.dart';
import 'package:myshopp/view/profile_view.dart';

import '../core/viewmodel/control_view_model.dart';
import '../widgets/custom_text.dart';
import 'cart_view.dart';
// one dev to role the all

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginView()
          : Get.find<AuthViewModel>().user == 'admin@gmail.com'
              ? Adminhome()
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
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Container(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/home2.png')),
          activeIcon: Container(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/home1.png')),
        ),
        BottomNavigationBarItem(
          label: "Cart",
          icon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/cart2.png')),
          activeIcon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/cart1.png')),
        ),
        BottomNavigationBarItem(
          label: "Auction",
          icon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/auc1.png')),
          activeIcon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/auc2.png')),
        ),
        BottomNavigationBarItem(
          label: "Favorites",
          icon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/heart1.png')),
          activeIcon: Icon(
            CommunityMaterialIcons.heart,
            size: 25,
          ),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/user1.png')),
          activeIcon: Container(
              width: 25,
              height: 25,
              child: Image.asset('assets/images/user2.png')),
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

Widget bottomNavigationBarr() {
  return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 300),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.shoppingBag,
                      text: 'Cart',
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: 'Favorites',
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.navigatorvalue,
                  onTabChange: (index) {
                    controller.changeSelectedvalue(index);
                  },
                ),
              ),
            ),
          ));
}

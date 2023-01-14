import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/core/viewmodel/profile_viewmodel.dart';
import 'package:myshopp/view/User_product_view.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/sellview.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/checkoutview_model.dart';
import 'cards_view.dart';
import 'edit profile/edit_profile_view.dart';
import 'notifications_view.dart';
import 'order_history_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(() => CheckoutViewModel());
    Get.put(AuthViewModel());
// one dev to role the all

    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => controller.loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
            appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
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
                'Profile',
                style: TextStyle(
                    fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
              )),
            ),
          ),
        ),
      ),
              body:Stack(
                children: [
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
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child:Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 16, left: 20),
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage('assets/images/prof.png'),
                                    foregroundImage:
                                        controller.currentUser!.pic != 'default'
                                            ? NetworkImage(
                                                controller.currentUser!.pic)
                                            : null),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CustomText(
                                        text: controller.currentUser!.name,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    CustomText(
                                      text: controller.currentUser!.email,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomListTile(
                          iconName: '1',
                          title: 'Edit Profile',
                          onTapFn: () {
                            Get.to(EditProfileView());
                          },
                        ),
                        CustomListTile(
                          iconName: 'sell2',
                          title: 'Want to Sell Something ?',
                          onTapFn: () {
                            Get.to(SellView());
                          },
                        ),
                        CustomListTile(
                          iconName: 'box (2)',
                          title: 'Manage Your Products',
                          onTapFn: () {
                            Get.to(UserProduct());
                          },
                        ),
                        CustomListTile(
                          iconName: '3',
                          title: 'Order History',
                          onTapFn: () {
                            Get.to(OrderHistoryView());
                          },
                        ),
                        CustomListTile(
                          iconName: '4',
                          title: 'Cards',
                          onTapFn: () {
                            Get.to(CardsView());
                          },
                        ),
                        CustomListTile(
                          iconName: '5',
                          title: 'Notifications',
                          onTapFn: () {
                            Get.to(NotificationsView());
                          },
                        ),
                        CustomListTile(
                          iconName: '6',
                          title: 'Log Out',
                          onTapFn: () {
                            Get.find<AuthViewModel>().signOut();
                            Get.offAll(LoginView());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  ),
                ],
              )  
            ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final VoidCallback onTapFn;

  const CustomListTile({
    required this.iconName,
    required this.title,
    required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapFn,
          leading: Image.asset(
            'assets/images/$iconName.png',
            height: 40,
            width: 40,
          ),
          title: CustomText(
            text: title,
            fontSize: 18,
          ),
          trailing: title == 'Log Out'
              ? null
              : Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/core/viewmodel/profile_viewmodel.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/checkoutview_model.dart';
import 'cards_view.dart';
import 'edit profile/edit_profile_view.dart';
import 'notifications_view.dart';
import 'order_history_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CheckoutViewModel());
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => controller.loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 70, right: 16, left: 20),
                    child: Column(
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
                                // TextButton(
                                //     onPressed: (() {
                                //       print(controller.currentUser!.name);
                                //    controller.SignOut();
                                //       // Get.off(LoginView());
                                //     }),
                                //     child: Text('signout'))
                                Column(
                                  children: [
                                    CustomText(
                                      text: controller.currentUser!.name,
                                      fontSize: 26,
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
                          height: 100,
                        ),
                        CustomListTile(
                          iconName: '1',
                          title: 'Edit Profile',
                          onTapFn: () {
                             Get.to(EditProfileView());
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
                            controller.SignOut();
                            Get.offAll(LoginView());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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

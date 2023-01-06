import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/view/admin/allUsers.dart';

import '../../core/viewmodel/profile_viewmodel.dart';
import '../../widgets/custom_text.dart';
import 'allProducts.dart';
import '../auth/login_screen.dart';

class Adminhome extends StatelessWidget {
  const Adminhome({key});
  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModel());
    Get.put(ProfileViewModel());

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
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
                  'Admin Panel',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontFamily: 'openSans'),
                )),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .06,
                    // one dev to role the all

                    width: width,
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
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: height * .03,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              SizedBox(
                height: height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (() {
                      Get.to(Allusers());
                    }),
                    child: Container(
                      width: width * .4,
                      height: height * 0.27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.17,
                            child: Image.asset(
                              'assets/images/pdd.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'Users',
                            style: const TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Cairo',
                                fontSize: 29,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .08,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Get.to(AdminProducts());
                    }),
                    child: Container(
                      width: width * .4,
                      height: height * 0.27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.17,
                            child: Image.asset(
                              'assets/images/prodd.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'Products',
                            style: const TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Cairo',
                                fontSize: 29,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                onTap: () {
                  Get.find<AuthViewModel>().signOut();
                  Get.offAll(LoginView());
                },
                leading: Image.asset(
                  'assets/images/6.png',
                  height: 40,
                  width: 40,
                ),
                title: CustomText(
                  text: 'Log Out',
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../core/viewmodel/profile_viewmodel.dart';

// class Upload extends StatefulWidget {
//   const Upload({Key? key}) : super(key: key);

//   @override
//   State<Upload> createState() => _UploadState();
// }
//  late String? sellername =
//                 Get.find<ProfileViewModel>().currentUser!.userId;
// class _UploadState extends State<Upload> {
//   // late File _imageFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//             child: ElevatedButton(
//           onPressed: () {},
//           child: const Text(
//             'Add ',
//             style: TextStyle(fontSize: 28),
//           ),
//         )),
//         ElevatedButton(
//           onPressed: () {

//             print(sellername);

//             // _openGallery();
//           },
//           child: const Text(
//             'Update   ',
//             style: TextStyle(fontSize: 28),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // _openGallery();
//           },
//           child: const Text(
//             'delete ',
//             style: TextStyle(fontSize: 28),
//           ),
//         ),
//       ],
//     ));
//   }
// }

import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/comments_viewModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myshopp/view/product_details_view.dart';
import '../core/viewmodel/home_view_model.dart';
import '../core/viewmodel/profile_viewmodel.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../core/viewmodel/selectImage_viewmodel.dart';
import '../model/product_model.dart';
import '../widgets/Custom_text_form_feild.dart';

import 'package:custom_rating_bar/custom_rating_bar.dart' as cs;
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/timer.dart';

class Upload extends StatefulWidget {
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String? _timeUntill = '1';
  List<String> _timeUntil = [];
  Timer? _timer;
  DateTime times1 = DateTime.now().add(const Duration(days: 1));
  DateTime times2 = DateTime.now().add(const Duration(days: 1));

  final DateTime times = DateTime.now().add(const Duration(hours: 24));
  void startTimer(DateTime x) {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        // for (int i = 0; i < products.length; i++) {
        //   _timeUntil[i] = TimeLeft.timeLeft(x);
        // }
        _timeUntill = TimeLeft.timeLeft(x);
        // print(_timeUntill); //function that we call
      });
    }); // Timer . periodic
  }
  // print(datetime2.difference(dateTime1).inDays);

  // const Upload({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    startTimer(times);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    startTimer(times);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    List<ProductModel> products = Get.find<HomeViewModel>().products.toList();

    Get.put(ProfileViewModel());
    Get.put(HomeViewModel());
    var y = 'ssss';
    var x = Get.find<ProfileViewModel>().currentUser;
    Get.put(CommentViewModel());
    var id = 'w4vUnZDSDII0yn36rz1y';
    var rate = 8;
    var reviews = 2;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 209, 208, 208),

      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 90,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   constraints: BoxConstraints(),
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   icon: Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  CustomText(
                    text: 'E auctions',
                    fontFamily: 'Baumans',
                    fontSize: 24,
                    alignment: Alignment.bottomCenter,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 10,
          ),
          
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 320,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return GestureDetector(
                      onTap: () {
                        // Get.to(
                        //   ProductDetailView(id: products[index].productId),
                        // );
                      },
                      child: Card(
                        //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        child: Container(
                          width: 164,
                          height: 300,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                height: 220,
                                width: 164,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    products[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 20),
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: products[index].name,
                                      fontSize: 15,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: '\$${products[index].price}',
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: 'Ends in $_timeUntill',
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 50, 116, 52),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // one dev to role the all

                  } else {
                    return OverflowBox(
                      maxHeight: 290 + 100,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            ProductDetailView(id: products[index].productId),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 70),
                          // width: 164,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                height: 220,
                                width: 164,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    products[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: products[index].name,
                                fontSize: 15,
                              ),
                              CustomText(
                                text: '\$${products[index].price}',
                                fontSize: 16,
                                color: primaryColor,
                              ),
                              CustomText(
                                text: 'Ends in $_timeUntill',
                                fontSize: 12,
                                color: Color.fromARGB(255, 50, 116, 52),
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      ),

      // Stack(
      //   children: [
      //     ClipPath(
      //       // shadow: const BoxShadow(
      //       //   color: Colors.white,
      //       //   offset: Offset(4, 4),
      //       //   blurRadius: 4,
      //       //   spreadRadius: 8,
      //       // ),
      //       clipper: CustomLoginShapeClipper4(),
      //       child: Container(
      //         color: primaryColor.withOpacity(0.5),
      //       ),
      //     ), ClipPath(
      //       // shadow: const BoxShadow(
      //       //   color: Colors.white,
      //       //   offset: Offset(4, 4),
      //       //   blurRadius: 4,
      //       //   spreadRadius: 8,
      //       // ),
      //       clipper: CustomLoginShapeClipper5(),
      //       child: Container(
      //         color: primaryColor,
      //       ),
      //     ), ClipPath(
      //       // shadow: const BoxShadow(
      //       //   color: Colors.white,
      //       //   offset: Offset(4, 4),
      //       //   blurRadius: 4,
      //       //   spreadRadius: 8,
      //       // ),
      //       clipper: CustomLoginShapeClipper6(),
      //       child: Container(
      //         color: primaryColor.withOpacity(0.5),
      //       ),
      //     ), ClipPath(
      //       // shadow: const BoxShadow(
      //       //   color: Colors.white,
      //       //   offset: Offset(4, 4),
      //       //   blurRadius: 4,
      //       //   spreadRadius: 8,
      //       // ),
      //       clipper: CustomLoginShapeClipper3(),
      //       child: Container(
      //         color: primaryColor,
      //       ),
      //     ),
      //     // ClipShadowPath(
      //     //   shadow:  const BoxShadow(
      //     //     color: Colors.black,
      //     //     offset: Offset(4, 4),
      //     //     blurRadius: 4,
      //     //     spreadRadius: 8,
      //     //   ),
      //     //   clipper: SmallClipper(),
      //     //   child: Container(
      //     //     color:
      //     //        Color.fromRGBO(162, 230, 209, 1),

      //     //   ),
      //     // ),

      //     Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           SizedBox(
      //             height: 80,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 const Padding(
      //                   padding: EdgeInsets.only(top: 40.0),
      //                   child: SizedBox(),
      //                 ),
      //                 const Text(
      //                   'Shopify',
      //                   style: TextStyle(
      //                     color: Colors.black,
      //                     fontFamily: 'Baumans',
      //                     fontSize: 26,
      //                   ),
      //                 ),
      //                 Container(
      //                   width: 30,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Form(
      //             child: Column(
      //                 // mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Padding(
      //                     padding: EdgeInsets.only(top: 20, left: 20.0),
      //                     child: Text('Welcome \n back!',
      //                         style: TextStyle(
      //                             color: Colors.black,
      //                             fontFamily: 'Cairo',
      //                             fontWeight: FontWeight.w600,
      //                             fontSize: 42)),
      //                   ),
      //                   const SizedBox(
      //                     height: 25,
      //                   ),
      //                   const Padding(
      //                     padding: EdgeInsets.only(left: 20.0),
      //                     child: Text(
      //                       'Email',
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Cairo',
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(
      //                         left: 20.0, right: 20, top: 9),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(20)),
      //                       height: 60,
      //                       width: 400,
      //                       // color: Colors.white,
      //                       child: TextFormField(
      //                         validator: (value) {
      //                           if (value == null) {
      //                             print('ERROR');
      //                           }
      //                         },
      //                         onSaved: (value) {},
      //                         decoration: const InputDecoration(
      //                           hintText: '  Enter your email address',
      //                           hintStyle: TextStyle(
      //                             color: Color.fromARGB(255, 151, 150, 150),
      //                             fontFamily: "Cairo",
      //                             fontWeight: FontWeight.w600,
      //                             fontSize: 16,
      //                           ),
      //                           border: InputBorder.none,
      //                           prefixIcon: Icon(Icons.email_outlined),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 18,
      //                   ),
      //                   const Padding(
      //                     padding: EdgeInsets.only(left: 20.0),
      //                     child: Text(
      //                       'Password',
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Cairo',
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(
      //                         left: 20.0, right: 20, top: 9),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(20)),
      //                       height: 60,
      //                       width: 400,
      //                       // color: Colors.white,
      //                       child: TextFormField(
      //                         obscureText: true,
      //                         validator: (value) {
      //                           if (value!.isEmpty)
      //                             return 'Password is incorrect';
      //                         },
      //                         onSaved: (value) {},
      //                         decoration: const InputDecoration(
      //                           hintText: '  Enter Your Password',
      //                           hintStyle: TextStyle(
      //                             color: Color.fromARGB(255, 151, 150, 150),
      //                             fontFamily: "Cairo",
      //                             fontWeight: FontWeight.w600,
      //                             fontSize: 16,
      //                           ),
      //                           border: InputBorder.none,
      //                           prefixIcon: Icon(Icons.lock_outlined),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 2,
      //                   ),
      //                   const Padding(
      //                     padding: EdgeInsets.only(left: 260.0),
      //                     child: Text(
      //                       'Forget password?',
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Cairo',
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 20,
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 76.0),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(20)),
      //                       height: 52,
      //                       width: 238,
      //                       child: ElevatedButton(
      //                         onPressed: () {},
      //                         style: ElevatedButton.styleFrom(
      //                           shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(20)),
      //                           primary: primaryColor,
      //                           elevation: 0,
      //                         ),
      //                         child: const Text(
      //                           'Sign in',
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontFamily: 'Cairo',
      //                               fontSize: 24,
      //                               fontWeight: FontWeight.w500),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 8,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       const Text(
      //                         'Don’t have an account yet ?',
      //                         style: TextStyle(
      //                             color: Color.fromARGB(255, 151, 150, 150),
      //                             fontFamily: 'Cairo',
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                       GestureDetector(
      //                         onTap: () {},
      //                         child: const Text(
      //                           ' sign up',
      //                           style: TextStyle(
      //                               color: Colors.black,
      //                               fontFamily: 'Cairo',
      //                               fontSize: 16,
      //                               fontWeight: FontWeight.w600),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   const Center(
      //                     child: Text(
      //                       'or',
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Cairo',
      //                           fontSize: 24,
      //                           fontWeight: FontWeight.w500),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {},
      //                         child: Container(
      //                           height: 52,
      //                           width: 92,
      //                           decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               borderRadius: BorderRadius.circular(13)),
      //                           child:
      //                               Image.asset('assets/images/google.png'),
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         width: 35,
      //                       ),
      //                       GestureDetector(
      //                         onTap: () {},
      //                         child: Container(
      //                           height: 52,
      //                           width: 92,
      //                           decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               borderRadius: BorderRadius.circular(13)),
      //                           child:
      //                               Image.asset('assets/images/facebook.png'),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //                 ]),
      //           )
      //         ]),
      //   ],
      // )
    );
    // body: ListView(
    //   padding: const EdgeInsets.all(16).copyWith(top: 24),
    //   children: [
    //     _buildDivider('Half icons'),
    //     cs.RatingBar(
    //       filledIcon: Icons.star,
    //       emptyIcon: Icons.star_border,
    //       onRatingChanged: (value) => debugPrint('$value'),
    //       initialRating: 3,
    //       maxRating: 5,
    //       alignment: Alignment.center,
    //     ),
    //     const SizedBox(height: 16),
    //     _buildDivider('Custom colors'),
    //     cs.RatingBar.readOnly(
    //       isHalfAllowed: true,
    //       alignment: Alignment.center,
    //       filledIcon: Icons.star,
    //       emptyIcon: Icons.star_border,
    //       emptyColor: Colors.redAccent,
    //       filledColor: Colors.greenAccent,
    //       halfFilledColor: Colors.amberAccent,
    //       halfFilledIcon: Icons.star_half,
    //       initialRating: 3.5,
    //       maxRating: 7,
    //     ),
    //     const SizedBox(height: 16),
    //     _buildDivider('Custom icons'),
    //     cs.RatingBar.readOnly(
    //       isHalfAllowed: true,
    //       alignment: Alignment.center,
    //       filledIcon: Icons.wb_sunny,
    //       halfFilledIcon: Icons.wb_cloudy,
    //       emptyIcon: Icons.ac_unit,
    //       emptyColor: Colors.blue,
    //       halfFilledColor: Colors.grey,
    //       initialRating: 4,
    //       maxRating: 5,
    //     ),
    //     const SizedBox(height: 16),
    //     _buildDivider('Vertical'),
    //     cs.RatingBar.readOnly(
    //       direction: Axis.vertical,
    //       isHalfAllowed: true,
    //       alignment: Alignment.center,
    //       filledIcon: Icons.star,
    //       emptyIcon: Icons.star_border,
    //       initialRating: 2,
    //       maxRating: 3,
    //       halfFilledIcon: Icons.star_half,
    //     ),
    //     const SizedBox(height: 16),
    //     _buildDivider('Aligned left'),
    //     cs.RatingBar.readOnly(
    //       isHalfAllowed: true,
    //       alignment: Alignment.centerLeft,
    //       filledIcon: Icons.face,
    //       filledColor: Colors.greenAccent,
    //       halfFilledColor: Colors.amberAccent,
    //       emptyIcon: Icons.face,
    //       initialRating: 3.5,
    //       maxRating: 5,
    //       halfFilledIcon: Icons.face,
    //     ),
    //     const SizedBox(height: 16),
    //     _buildDivider('Aligned right'),
    //     cs.RatingBar.readOnly(
    //       isHalfAllowed: true,
    //       alignment: Alignment.centerRight,
    //       filledIcon: Icons.star,
    //       emptyIcon: Icons.star_border,
    //       filledColor: Colors.greenAccent,
    //       halfFilledColor: Colors.greenAccent,
    //       initialRating: 4.2,
    //       maxRating: 5,
    //       halfFilledIcon: Icons.star_half,
    //     ),
    //   ],
    // ),
  }
}

class BigClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.325);

//    path.lineTo(0.0, size.height * 0.3);

    var firstEndpoint = Offset(size.width * 0.22, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.125, size.height * 0.30);

//    var firstEndpoint = Offset(size.width * 0.17, size.height * 0.2);
//    var firstControlPoint = Offset(size.width * 0.075, size.height * 0.30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.0725);
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.0825);

//    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.05);
//    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.06);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width, size.height * 0.0);
    var thirdControlPoint = Offset(size.width * 0.99, size.height * 0.05);

//    var thirdEndpoint = Offset(size.width * 0.95, size.height * 0.0);
//    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.05);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

class SmallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 999;
    path.lineTo(
        -0.003999999999997783 * _xScaling, 341.78499999999997 * _yScaling);
    path.cubicTo(
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      23.461000000000002 * _xScaling,
      363.15099999999995 * _yScaling,
      71.553 * _xScaling,
      363.15099999999995 * _yScaling,
    );
    path.cubicTo(
      119.645 * _xScaling,
      363.15099999999995 * _yScaling,
      142.21699999999998 * _xScaling,
      300.186 * _yScaling,
      203.29500000000002 * _xScaling,
      307.21 * _yScaling,
    );
    path.cubicTo(
      264.373 * _xScaling,
      314.234 * _yScaling,
      282.666 * _xScaling,
      333.47299999999996 * _yScaling,
      338.408 * _xScaling,
      333.47299999999996 * _yScaling,
    );
    path.cubicTo(
      394.15000000000003 * _xScaling,
      333.47299999999996 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final BoxShadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(child: child, clipper: clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final BoxShadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint()
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        shadow.spreadRadius,
      );
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomLoginShapeClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.5);

    var firstEndpoint = Offset(size.width, size.height * 0.25);
    var firstControlPoint = Offset(size.width * 0.75, size.height * 0.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.85);

    var firstEndpoint = Offset(size.width, size.height * 0.7);
    var firstControlPoint = Offset(size.width * 0.6, size.height * 0.85);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomSignUpShapeClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.30);

    var firstEndpoint = Offset(size.width, size.height * 0.15);
    var firstControlPoint = Offset(size.width * 0.5, size.height * 0.13);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomSignUpShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndpoint = Offset(size.width, size.height * 0.52);
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.52);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomSignUpShapeClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height * 0.8);

    var firstEndpoint = Offset(size.width, size.height * 0.7);
    var firstControlPoint = Offset(size.width * 0.70, size.height * 0.8);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//************************ for login design 3 *********************************
class CustomLoginShapeClipper4 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.325);

//    path.lineTo(0.0, size.height * 0.3);

    var firstEndpoint = Offset(size.width * 0.22, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.125, size.height * 0.30);

//    var firstEndpoint = Offset(size.width * 0.17, size.height * 0.2);
//    var firstControlPoint = Offset(size.width * 0.075, size.height * 0.30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.0725);
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.0825);

//    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.05);
//    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.06);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width, size.height * 0.0);
    var thirdControlPoint = Offset(size.width * 0.99, size.height * 0.05);

//    var thirdEndpoint = Offset(size.width * 0.95, size.height * 0.0);
//    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.05);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper5 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.3);

    var firstEndpoint = Offset(size.width * 0.17, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.075, size.height * 0.30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.05);
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.06);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width * 0.95, size.height * 0.0);
    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.05);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);

//    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.05, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.7);

    var firstEndpoint = Offset(size.width * 0.83, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.925, size.height * 0.70);
//
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);
//
    var secondEndpoint = Offset(size.width * 0.30, size.height * 0.95);
    var secondControlPoint =
        Offset(size.width * 0.70, size.height * 0.92); //height
//
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);
//
    var thirdEndpoint = Offset(size.width * 0.05, size.height);
    var thirdControlPoint =
        Offset(size.width * 0.1, size.height * 0.95); //width

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);
//
//
//    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper6 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.675);

    var firstEndpoint = Offset(size.width * 0.78, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.875, size.height * 0.70);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.30, size.height * 0.9275);
    var secondControlPoint = Offset(size.width * 0.70, size.height * 0.8975);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width * 0.0, size.height);
    var thirdControlPoint = Offset(size.width * 0.04, size.height * 0.95);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//************************ for LoginDesign4 *********************************//

class LoginDesign4ShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.8);

    var firstEndpoint = Offset(size.width * 0.6, size.height * 0.55);
    var firstControlPoint = Offset(size.width * 0.40, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.8, size.height * 0.35);
    var secondControlPoint = Offset(size.width * 0.7, size.height * 0.35);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width * 0.9, size.height * 0.25);
    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.35);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);

    var fourthEndpoint = Offset(size.width * 0.78, size.height * 0.15);
    var fourthControlPoint = Offset(size.width * 0.9, size.height * 0.15);

    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndpoint.dx, fourthEndpoint.dy);

    var fifthEndpoint = Offset(size.width * 0.5, size.height * 0);
    var fifthControlPoint = Offset(size.width * 0.6, size.height * 0.15);

    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndpoint.dx, fifthEndpoint.dy);
//    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//************************ for LoginDesign5 *********************************//

class SemiCircleShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.0);

    var firstEndpoint = Offset(size.width * 0.9, size.height * 0.0);
    var firstControlPoint = Offset(size.width * 0.45, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class SemiCircleShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.7, size.height * 0.0);

    var firstEndpoint = Offset(size.width, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.6, size.height * 0.7);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//************************ for LoginDesign6 *********************************//

class WaveShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.0, size.height * 0.6);

    var firstEndpoint = Offset(size.width * 0.5, size.height * 0.6);
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.4);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width, size.height * 0.8);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.8);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class ReverseWaveShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.0, size.height * 0.8);

    var firstEndpoint = Offset(size.width * 0.5, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.25, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width, size.height * 0.6);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.6);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//************************ for LoginDesign7 *********************************//

class LoginDesign7ShapeClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.0, size.height * 0.5);

    var firstEndpoint = Offset(size.width * 0.6, size.height * 0.0);
    var firstControlPoint = Offset(size.width * 0.3, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class LoginDesign7ShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.0);

    var firstEndpoint = Offset(size.width, size.height);
    var firstControlPoint = Offset(size.width * 0.2, size.height * 1);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class LoginDesign7ShapeClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.0, size.height * 0.9);

    var firstEndpoint = Offset(size.width * 0.3, size.height);
    var firstControlPoint = Offset(size.width * 0.3, size.height * 0.8);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

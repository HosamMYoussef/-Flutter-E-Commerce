import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/Favorites_%20view_model.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/checkoutview_model.dart';
import '../core/viewmodel/home_view_model.dart';
import 'checkout_view.dart';

class FavoritesView extends StatelessWidget {
  late final List<FavoritesviewModel> products;

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesviewModel());
    return GetBuilder<FavoritesviewModel>(
        init: Get.put(FavoritesviewModel()),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.all(120.0),
                  child: Text(
                    'Favorites',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
              body: controller.favoritesProductModel.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty.gif',
                          width: 350,
                          height: 350,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomText(
                          text: "Your  Cart is empty... ",
                          fontSize: 23,
                          alignment: Alignment.topCenter,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: GetBuilder<HomeViewModel>(
                                        builder: (controller) =>
                                            GestureDetector(
                                          onTap: () {
                                            Get.to(ProductDetailView(
                                                productModel: controller
                                                    .products[index]));
                                          },
                                          child: GetBuilder<FavoritesviewModel>(
                                            builder: (controller) =>
                                                Image.network(
                                              controller
                                                  .favoritesProductModel[index]
                                                  .image,
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black54,
                                        ),
                                        width: 150,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 20,
                                        ),
                                        child: Text(
                                          controller
                                              .favoritesProductModel[index]
                                              .name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),Positioned(
                                      bottom: 10,
                                      left: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                         // color: Colors.black54,
                                        ),
                                        width: 150,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 20,
                                        ),
                                        child: CustomText(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          text:
                                              '\$${controller.favoritesProductModel[index].price.toString()}'),
                                      ),
                                    ),Positioned(
                                      bottom: 10,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black54,
                                        ),
                                        width: 50,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 1,
                                          horizontal: 5,
                                        ),
                                        child:  IconButton(
                                        onPressed: () {  controller.removeProduct(controller
                            .favoritesProductModel[index].productId);},
                                        icon: Image.asset(
                                          "assets/images/dislike1.png",width: 30,height: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                      ),
                                    )
                                  ],
                                ),
                            //     Padding(
                            //       padding: EdgeInsets.all(20),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceAround,
                            //         children: <Widget>[
                            //           CustomText(
                            //               color: primaryColor,
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 20,
                            //               text:
                            //                   '\$${controller.favoritesProductModel[index].price.toString()}'),
                            //           IconButton(
                            //             onPressed: () {  controller.removeProduct(controller
                            // .favoritesProductModel[index].productId);},
                            //             icon: Image.asset(
                            //               "assets/images/dislike.png",width: 30,height: 30,
                            //               color: Colors.black,
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: controller.favoritesProductModel.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                    ),
            ));

    // Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(40.0),
    //         child: Text("Favorties"),
    //       ),

    //       Expanded(
    //         child: Container(
    //           padding: EdgeInsets.only(top: 50, right: 16, left: 16),
    //           child: ListView.separated(
    //             separatorBuilder: (context, index) {
    //               return SizedBox(
    //                 height: 20,
    //               );
    //             },
    //             itemBuilder: (context, index) {
    //               return Dismissible(
    //                 key: Key(
    //                     controller.favoritesProductModel[index].productId),
    //                 background: Container(
    //                   color: Colors.red,
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(right: 33),
    //                   child: Icon(
    //                     Icons.delete_outline,
    //                     color: Colors.white,
    //                     size: 30,
    //                   ),
    //                 ),
    //                 onDismissed: (direction) {
    //                   if (direction == DismissDirection.endToStart) {
    //                     controller.removeProduct(controller
    //                         .favoritesProductModel[index].productId);
    //                   }
    //                 },
    //                 child: Card(
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20)),
    //                   elevation: 4,
    //                   child: Row(
    //                     children: [
    //                       Container(
    //                         decoration: BoxDecoration(
    //                             borderRadius:
    //                                 BorderRadius.circular(29)),
    //                         width: 120,
    //                         height: 120,
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(20),
    //                             bottomLeft: Radius.circular(20),
    //                           ),
    //                           child: Image.network(
    //                             controller
    //                                 .favoritesProductModel[index].image,
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: 30,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 15.0),
    //                         child: Column(
    //                           crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                           children: [
    //                             CustomText(
    //                               text: controller
    //                                   .favoritesProductModel[index].name,
    //                               fontSize: 16,
    //                             ),
    //                             CustomText(
    //                               text:
    //                                   '\$${controller.favoritesProductModel[index].price.toString()}',
    //                               color: primaryColor,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 16,
    //                             ),
    //                             SizedBox(
    //                               height: 16,
    //                             ),
    //                             Container(
    //                               width: 95,
    //                               height: 30,
    //                               decoration: BoxDecoration(
    //                                 borderRadius:
    //                                     BorderRadius.circular(4),
    //                                 color: Colors.grey.shade200,
    //                               ),
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 10),
    //                                 child: Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment
    //                                             .spaceBetween,
    //                                     children: [
    //                                       GestureDetector(
    //                                         child: Icon(
    //                                           Icons.add,
    //                                           color: Colors.black,
    //                                           size: 20,
    //                                         ),
    //                                         onTap: () {
    //                                           // controller
    //                                           //     .increaseQuantity(
    //                                           //         index);
    //                                         },
    //                                       ),
    //                                       CustomText(
    //                                         text: ('2'),
    //                                         alignment: Alignment.center,
    //                                         fontSize: 16,
    //                                         color: Colors.black,
    //                                       ),
    //                                       Container(
    //                                         // padding: EdgeInsets.only(bottom: 20),
    //                                         child: GestureDetector(
    //                                           child: Icon(
    //                                             Icons.remove,
    //                                             color: Colors.black,
    //                                             size: 20,
    //                                           ),
    //                                           onTap: () {
    //                                             // controller
    //                                             //   ..decreaseQuantity(
    //                                             //       index);
    //                                           },
    //                                         ),
    //                                       ),
    //                                     ]),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //             itemCount: controller.favoritesProductModel.length,
    //           ),
    //         ),
    //       ),

    //     ],
    //   ),
  }
}

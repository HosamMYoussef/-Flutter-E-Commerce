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
                        'Favorites',
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontFamily: 'Baumans'),
                      )),
                    ),
                  ),
                ),
              ),
              body: controller.favoritesProductModel.length == 0
                  ? Stack(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/caart.svg',
                                  width: 350,
                                  height: 350,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomText(
                                  text: "Your Favorites will show here... ",
                                  fontSize: 23,
                                  fontFamily: 'Baumans',
                                  alignment: Alignment.topCenter,
                                )
                              ],
                            )),
                      ],
                    )
                  : Stack(
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ListView.separated(
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(ProductDetailView(
                                        id: controller
                                            .favoritesProductModel[index]
                                            .productId,
                                      ));
                                    },
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                child: GetBuilder<
                                                    FavoritesviewModel>(
                                                  builder: (controller) =>
                                                      Image.network(
                                                    controller
                                                        .favoritesProductModel[
                                                            index]
                                                        .image,
                                                    height: 200,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black54,
                                                  ),
                                                  width: 150,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                    horizontal: 20,
                                                  ),
                                                  child: Text(
                                                    controller
                                                        .favoritesProductModel[
                                                            index]
                                                        .name,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                    softWrap: true,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    // color: Colors.black54,
                                                  ),
                                                  width: 150,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                    horizontal: 20,
                                                  ),
                                                  child: CustomText(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      text:
                                                          '\$${controller.favoritesProductModel[index].price.toString()}'),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                right: 0,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.black54,
                                                    ),
                                                    width: 50,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 1,
                                                      horizontal: 5,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        controller.removeProduct(
                                                            controller
                                                                .favoritesProductModel[
                                                                    index]
                                                                .productId);
                                                      },
                                                      icon: Image.asset(
                                                        "assets/images/dislike1.png",
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    controller.favoritesProductModel.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 15,
                                  );
                                },
                              ),
                            )),
                      ],
                    ),
            ));
  }
}

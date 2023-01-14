import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/profile_view.dart';

import '../../constants.dart';
import '../core/viewmodel/checkoutview_model.dart';
import '../widgets/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel);

    return Scaffold(
     appBar: AppBar(
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
                'Order History',
                style: TextStyle(
                    fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
              )),
            ),
          ),
        ),
      
      body: Column(
        children: [
          Stack(children: [
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
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 35,
                    )))
          ]),
          Expanded(
            child: GetBuilder<CheckoutViewModel>(
              init: Get.find<CheckoutViewModel>(),
              builder: (controller) => controller.checkouts.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/noo.svg',
                          width: 400,
                          height: 400,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "No Orders Yet... ",
                          fontSize: 23,
                          alignment: Alignment.topCenter,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              controller.checkouts[index].date,
                                          color: Colors.grey,
                                        ),
                                        CustomText(
                                          text: 'Pending',
                                          color: Colors.red.shade300,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    CustomText(
                                      text: controller.checkouts[index].street,
                                    ),
                                    CustomText(
                                      text: controller.checkouts[index].city,
                                    ),
                                    CustomText(
                                      text: controller.checkouts[index].state,
                                    ),
                                    CustomText(
                                      text: controller.checkouts[index].country,
                                    ),
                                    CustomText(
                                      text: controller.checkouts[index].phone,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: 'Total Bill',
                                          color: primaryColor,
                                        ),
                                        CustomText(
                                          text:
                                              '\$${controller.checkouts[index].totalPrice}',
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: controller.checkouts.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

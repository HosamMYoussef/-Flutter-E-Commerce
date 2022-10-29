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
      body: Column(
        children: [
          Container(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Get.back();
                      // Get.put(CheckoutViewModel);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Order History',
                    fontFamily: 'Baumans',
                    fontSize: 24,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
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

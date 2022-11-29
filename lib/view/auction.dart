import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/product_details_view.dart';

import '../constants.dart';
import '../core/viewmodel/home_view_model.dart';
import '../model/product_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/timer.dart';

class AuctionView extends StatefulWidget {
  const AuctionView({Key? key}) : super(key: key);

  @override
  State<AuctionView> createState() => _AuctionViewState();
}

class _AuctionViewState extends State<AuctionView> {
  String? _timeUntill = ' ';
  List<String> _timeUntil = [];
  Timer? _timer;
  DateTime times1 = DateTime.now().add(const Duration(days: 1));
  DateTime times2 = DateTime.now().add(const Duration(days: 1));

  final DateTime times = DateTime.now().add(const Duration(hours: 24));
  void startTimer(DateTime x) {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _timeUntill = TimeLeft.timeLeft(x);
      });
    }); // Timer . periodic
  }

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
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
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
          SizedBox(
            height: 29,
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 311,
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
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
                          margin: EdgeInsets.only(top: 50),
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
                                color: Colors.black,
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
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/view/auction_details_view.dart';
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

  Timer? _timer;

  final DateTime times = DateTime.now().add(const Duration(hours: 24));
  void startTimer(DateTime x) {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!mounted) return;

      setState(() {
        _timeUntill = TimeLeft.timeLeft(x);
      });
    }); // Timer . periodic
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer(times);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // startTimer(times);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    List<AuctionModel> auctions = Get.find<HomeViewModel>().auctions.toList();
    DateTime time1 = DateTime.parse(auctions[0].end);
    DateTime time2 = DateTime.parse(auctions[0].start);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 90,
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
                  mainAxisExtent: 300,
                ),
                itemCount: auctions.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(AuctionProductDetails(id: auctions[index].auctionId));
                      },
                      // one dev to role the all

                      child: Card(
                        elevation: 0,
                        child: Container(
                          width: 164,
                          height: 290,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                height: 209,
                                width: 164,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    auctions[index].image,
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
                                      text: auctions[index].name,
                                      fontSize: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text: '\$${auctions[index].price}',
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (() {
                                        // print(timeee);
                                      }),
                                      child: CustomText(
                                        text: 'Ends in ${TimeLeft.timeLeft(DateTime.parse(auctions[index].end))}',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
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
                            AuctionProductDetails(id: auctions[index].auctionId),
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
                                height: 209,
                                width: 164,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    auctions[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: auctions[index].name,
                                fontSize: 15,
                              ),
                              CustomText(
                                text: '\$${auctions[index].price}',
                                fontSize: 16,
                                color: primaryColor,
                              ),
                              
                              CustomText(
                                text: 'Ends in ${TimeLeft.timeLeft(DateTime.parse(auctions[index].end))}',
                                fontSize: 12,
                                color: Colors.black,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 20,
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

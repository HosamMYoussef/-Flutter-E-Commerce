import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/view/auction_details_view.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/widgets/appbar.dart';

import '../constants.dart';
import '../core/viewmodel/home_view_model.dart';
import '../model/product_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/timer.dart';
import 'auction_sell.dart';

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
                'E auctions',
                style: TextStyle(
                    fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
              )),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ListTile(
                          onTap: () {
                            Get.to(AuctionSell());
                          },
                          leading: Image.asset(
                            'assets/images/sell2.png',
                            height: 40,
                            width: 40,
                          ),
                          title: CustomText(
                            text: 'Want to auction Something ?',
                            fontSize: 18,
                            fontFamily: 'Amazon',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                        Get.to(AuctionProductDetails(
                            id: auctions[index].auctionId));
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
                                        text: TimeLeft.timeLeft(DateTime.parse(
                                                    auctions[index].end)) ==
                                                "Finished"
                                            ? "Finished"
                                            : 'Ends in ${TimeLeft.timeLeft(DateTime.parse(auctions[index].end))}',
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
                            AuctionProductDetails(
                                id: auctions[index].auctionId),
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
                                text: TimeLeft.timeLeft(DateTime.parse(
                                            auctions[index].end)) ==
                                        "Finished"
                                    ? "Finished"
                                    : 'Ends in ${TimeLeft.timeLeft(DateTime.parse(auctions[index].end))}',
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

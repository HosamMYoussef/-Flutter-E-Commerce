import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../constants.dart';
import '../core/viewmodel/home_view_model.dart';
import '../model/product_model.dart';
import '../widgets/timer.dart';
import 'bid.dart';

class AuctionProductDetails extends StatefulWidget {
  String id;

  AuctionProductDetails({required this.id});

  @override
  State<AuctionProductDetails> createState() => _AuctionProductDetailsState();
}

class _AuctionProductDetailsState extends State<AuctionProductDetails> {
  String? _timeUntill = ' ';
  Timer? _timer;

  final DateTime times = DateTime.now().add(const Duration(hours: 2));

  String _timeUntilll = "";

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    var bids = Get.find<HomeViewModel>().bids;

    var auction = Get.find<HomeViewModel>()
        .auctions
        .firstWhere((prod) => prod.auctionId == widget.id);
    String _timeUntil = "";
    DateTime time2 = DateTime.parse(auction.end);
    String timeee = TimeLeft.timeLeft(time2);
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
      body: Stack(
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
              child: Column(children: [
                  const SizedBox(
                            height: 10,
                          ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                          Container(
                            height: MediaQuery.of(context).size.height * .5,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                auction.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            maxLines: 2,
                            text: auction.name,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amazon',
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            maxLines: 2,
                            text: '\$${auction.price}',
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amazon',
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: '${auction.bids} bids',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                TextSpan(
                                  text: ' | $timeee',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              height: 52,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SelectBid(id: auction.auctionId);
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  primary: primaryColor,
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Place bid',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'opsans',
                                    fontSize: 22,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // one dev to role the all

                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            text: 'About this item ',
                            fontSize: 20,
                            fontFamily: 'opensans',
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Condition',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 150,
                                child: CustomText(
                                  text: auction.condition,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Quantity',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 100,
                                child: CustomText(
                                  text: '1 available',
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Category',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 100,
                                child: CustomText(
                                  text: auction.category,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Type',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 100,
                                child: CustomText(
                                  text: auction.type,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomText(
                            text: 'Item description from the seller  ',
                            fontSize: 18,
                            fontFamily: 'opensans',
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 14),
                          Text(auction.description),
                          const SizedBox(height: 20),
                          CustomText(
                            text: 'More like this ',
                            fontSize: 18,
                            fontFamily: 'opensans',
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _listViewProducts(),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            text: 'Bidding ',
                            fontSize: 18,
                            fontFamily: 'opensans',
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Time left ',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 100,
                                child: CustomText(
                                  text: '$timeee',
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: CustomText(
                                  text: 'Bids',
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 100,
                                child: CustomText(
                                  text: auction.bids,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          // Column(
                          //   children: [
                          //     for (int i = 0; i < bids.length; i++)
                          //       Column(
                          //         children: [
                          //           Text(bids[i].auctionId),
                          //           Text(bids[i].price),
                          //           Text(bids[i].userId),
                          //           const SizedBox(
                          //             height: 40,
                          //           ),
                          //         ],
                          //       )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }

  _listViewProducts() {
    List<AuctionModel> products = Get.find<HomeViewModel>().auctions.toList();
     products.removeWhere((element) => element.auctionId == widget.id);
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 260,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return ProductDetailView(id: products[index].productId);
                //     },
                //   ),
                // );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 180,
                      width: 164,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          products[index].image,
                          fit: BoxFit.cover,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomText(
                      text: products[index].name,
                      fontSize: 16,
                      maxLines: 2,
                    ),
                    CustomText(
                      text: products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      fontWeight: FontWeight.bold,
                      text: '\$${products[index].price}',
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15,
            );
          },
        ),
      ),
    );
  }
}

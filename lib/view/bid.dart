import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/auction_view_model.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/model/bid_model.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import '../constants.dart';
import '../core/viewmodel/home_view_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/timer.dart';

class SelectBid extends StatefulWidget {
  String id;

  SelectBid({
    required this.id,
  });
  @override
  State<SelectBid> createState() => _SelectBidState();
}

class _SelectBidState extends State<SelectBid> {
  String text = '0';

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
  Widget build(BuildContext context) {
    var bids = Get.find<HomeViewModel>().bids;

    var auction = Get.find<HomeViewModel>()
        .auctions
        .firstWhere((auction) => auction.auctionId == widget.id);
    DateTime time2 = DateTime.parse(auction.end);
    String timeee = TimeLeft.timeLeft(time2);
    Get.put(AuctionViewModel());

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 24, left: 16, right: 16, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          "assets/images/x2.png",
                          fit: BoxFit.fill,
                          width: 50,
                          height: 50,
                          // color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(children: [
                            TextSpan(
                              text: '\$${auction.price}  ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const TextSpan(
                              text: '| Starting bid | ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            TextSpan(
                              text: '$timeee',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ])),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          CustomText(
            text: '\$${text}  ',
            alignment: Alignment.center,
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
          SizedBox(
            height: 60,
          ),
          NumericKeyboard(
            onKeyboardTap: onKeyboardTap,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 28,
            ),
            rightButtonFn: () {
              if (text.length < 1) {
                text = '0';
              } else {
                setState(() {
                  text = text.substring(0, text.length - 1);
                });
              }
              if (text.length < 1) {
                text = '0';
              }
            },
            rightIcon: const Icon(
              Icons.backspace_outlined,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CustomText(
              text:
                  'When you confirm your bid, it means you\'re committing to buy ',
              fontSize: 13,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CustomText(
              text: 'this item if you\'re the winning bidder ',
              fontSize: 13,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 52,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: ()async {
                  //? adding BID  to memory
                  auction.bids = (int.parse(auction.bids) + 1).toString();
                  bids.add(
                    BidModel(
                      auctionId: auction.auctionId,
                      price: text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  );
                  //? adding bid to fireStore
                  Get.find<AuctionViewModel>().price = text;
                  Get.find<AuctionViewModel>().productId = auction.auctionId;

                  await   Get.find<AuctionViewModel>().addBidToFireStore();
                  await  Get.find<HomeViewModel>().updateBidCount(auction.auctionId,
                  (int.parse(auction.bids) + 1).toString());
                   ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  'your bid was successfully added  ',
                                ),
                                duration: const Duration(seconds: 2),
                              ));
                  Get.back();
                },
                // one dev to role the all

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  primary: primaryColor,
                  elevation: 0,
                ),
                child: const Text(
                  'Confirm bid',
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
        ],
      ),
    );
  }

  void onKeyboardTap(String value) {
    setState(() {
      if (text == '0') {
        text = value;
      } else {
        text = text + value;
      }
    });
  }
}

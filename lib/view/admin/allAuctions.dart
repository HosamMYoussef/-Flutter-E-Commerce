import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/view/auction_sell.dart';
import 'package:myshopp/view/sellview.dart';

import '../../constants.dart';
import '../../core/viewmodel/home_view_model.dart';
import '../../model/product_model.dart';
import '../../widgets/custom_text.dart';

class AdminAuctions extends StatefulWidget {
  const AdminAuctions({Key? key}) : super(key: key);

  @override
  State<AdminAuctions> createState() => _AdminAuctionsState();
}
// one dev to role the all

class _AdminAuctionsState extends State<AdminAuctions> {
  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileViewModel());
    List<AuctionModel> productsdata =
        Get.find<HomeViewModel>().auctions.toList();
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
                'all auctions',
                style: TextStyle(
                    fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
              )),
            ),
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
                    child: SizedBox(height: 30,)))
          ]),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(ProductDetailView(id: productsdata[index].productId));
                  },
                  child: ListTile(
                    title: Text(productsdata[index].name),
                    leading: CircleAvatar(
                      radius: 30,
                    backgroundColor: Colors.white,
                      foregroundImage: NetworkImage(productsdata[index].image),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(children: [
                      SizedBox(width: 45,),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text('Are you Sure?'),
                                      content: const Text(
                                        'Do u want to remove the product from the shop',
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('No'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            print(
                                                productsdata[index].auctionId);
                                            Get.find<HomeViewModel>()
                                                .deleteAuctionsFromFireStore(
                                                    productsdata[index]
                                                        .auctionId);
                                            setState(() {});
                                            Get.back();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    )));
                          },
                          icon: Icon(
                            CupertinoIcons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const Divider()
              ],
            ),
            itemCount: productsdata.length,
          ),
        ),

        // Text(productsdata[0].name),
        // Text(productsdata[1].name)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AuctionSell());
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

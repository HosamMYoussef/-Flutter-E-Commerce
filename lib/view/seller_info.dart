import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/view/search_view.dart';
import 'package:myshopp/widgets/appbar.dart';
import '../constants.dart';
import '../core/viewmodel/comments_viewModel.dart';
import '../core/viewmodel/home_view_model.dart';
import '../core/viewmodel/profile_viewmodel.dart';
import '../model/comment_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';
import '../widgets/custom_text.dart';
import 'package:intl/intl.dart';

class SellerInfo extends StatefulWidget {
  SellerInfo({required this.id});
  String id;

  @override
  State<SellerInfo> createState() => _SellerInfoState();
}

class _SellerInfoState extends State<SellerInfo> {
  @override
  Widget build(BuildContext context) {
    var comment = Get.find<HomeViewModel>().comments;
    final fieldText = TextEditingController();

    List<CommentModel> comments =
        comment.where((meal) => meal.productId == widget.id).toList();
    var y = Get.find<HomeViewModel>().users;
    UserModel sellerInfo = y.firstWhere((meal) => meal.userId == widget.id);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .02,
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
                  // one dev to role the all

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, right: 16, left: 10),
                  child: Column(
                    children: [
                      CustomText(
                        fontFamily: 'Amazon',
                        fontWeight: FontWeight.w400,
                        text: sellerInfo.name,
                        fontSize: 24,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: 'Rating :',
                        // fontWeight: FontWeight.w400,
                        // fontFamily: 'Amazon',
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 16, left: 10),
                child: Column(
                  children: [
                    CustomText(
                      fontFamily: 'Amazon',
                      fontWeight: FontWeight.w400,
                      text: 'About Seller',
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    CustomText(
                      text:
                          '${sellerInfo.name}  is committed to providing each customer with the highest standard of customer service. ',
                      // fontWeight: FontWeight.w400,
                      // fontFamily: 'Amazon',
                      maxLines: 3,
                      fontSize: 17,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, right: 16, left: 10),
                  child: Column(
                    children: [
                      CustomText(
                        fontFamily: 'Amazon',
                        fontWeight: FontWeight.w400,
                        text: '${sellerInfo.name} Products',
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _listViewProducts(),
                    ],
                  )),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Reviews ',
                      fontFamily: 'Amazon',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < comments.length; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      child: comments[i].pic.length <= 20
                                          ? Image.asset(
                                              'assets/images/prof.png')
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                  comments[i].pic),
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    CustomText(
                                      text: (comments[i].name),
                                      fontSize: 16,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: RichText(
                                    text: TextSpan(
                                        // style: DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(
                                              text: 'Reviewed on ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54)),
                                          TextSpan(
                                              text: comments[i].date,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54)),
                                        ]),
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Text(comments[i].details,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(
                                height: 2,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, right: 20, top: 9),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        height: 60,
                        width: 400,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: TextFormField(
                            controller: fieldText,
                            validator: (value) {
                              if (value == null) {
                                print('ERROR');
                              }
                            },
                            onChanged: (value) {
                              Get.find<CommentViewModel>().details = value;
                              Get.find<CommentViewModel>().pic =
                                  Get.find<ProfileViewModel>().currentUser!.pic;
                              Get.find<CommentViewModel>().name =
                                  Get.find<ProfileViewModel>()
                                      .currentUser!
                                      .name;
                              Get.find<CommentViewModel>().productid =
                                  widget.id;
                            },
                            decoration: InputDecoration(
                                hintText: 'Write a review',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 151, 150, 150),
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        comment.add(CommentModel(
                                            productId: widget.id,
                                            details:
                                                Get.find<CommentViewModel>()
                                                    .details!,
                                            name: Get.find<ProfileViewModel>()
                                                .currentUser!
                                                .name,
                                            pic: Get.find<ProfileViewModel>()
                                                .currentUser!
                                                .pic,
                                            date: DateFormat.yMMMd()
                                                .format(DateTime.now())));
                                      });
                                      Get.find<CommentViewModel>()
                                          .addCommentsToFireStore();
                                      fieldText.clear();
                                    },
                                    icon: const Icon(
                                      Icons.send_outlined,
                                      color: primaryColor,
                                    ))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _searchTextFormField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: Colors.white,
  //     ),
  //     child: TextFormField(
  //       decoration: const InputDecoration(
  //         hintText: "Search Shopify",
  //         border: InputBorder.none,
  //         prefixIcon: Icon(
  //           Icons.search,
  //           color: Colors.black54,
  //         ),
  //       ),
  //       onFieldSubmitted: (value) {
  //         Get.to(SearchView(value));
  //       },
  //     ),
  //   );
  // }

  _listViewProducts() {
    List<ProductModel> products = Get.find<HomeViewModel>()
        .products
        .where((meal) => meal.sellerId == widget.id)
        .toList();
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetailView(id: products[index].productId);
                    },
                  ),
                );
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
                      height: 240,
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

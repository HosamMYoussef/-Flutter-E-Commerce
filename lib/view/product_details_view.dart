import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:line_icons/line_icons.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/core/viewmodel/comments_viewModel.dart';
import 'package:myshopp/core/viewmodel/profile_viewmodel.dart';
import 'package:myshopp/model/cart_product_model.dart';
import 'package:myshopp/model/comment_model.dart';
import 'package:myshopp/model/product_model.dart';
import 'package:myshopp/view/Favorites_view.dart';
import 'package:myshopp/view/checkout_view.dart';
import 'package:myshopp/view/profile_view.dart';
import 'package:myshopp/view/seller_info.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/Favorites_ view_model.dart';
import '../core/viewmodel/checkoutview_model.dart';
import '../core/viewmodel/home_view_model.dart';
import '../model/Favorites_model.dart';

class ProductDetailView extends StatefulWidget {
  // ProductModel productModel;
  String id;

  ProductDetailView({required this.id});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late String cat;

  @override
  Widget build(BuildContext context) {
    Get.put(CommentViewModel());
    final fieldText = TextEditingController();

    var x = Get.find<HomeViewModel>().products;
    // print(comments.length);
    var y = Get.find<HomeViewModel>().users;
    final productModel = x.firstWhere((meal) => meal.productId == widget.id);
    var comment = Get.find<HomeViewModel>().comments;
    List<CommentModel> comments =
        comment.where((meal) => meal.productId == widget.id).toList();
    cat = productModel.category;
    var username;
    var userId;

    if (productModel.sellerId == null) {
      username = 'Shopify';
      userId = 'def';
    } else {
      userId =
          y.firstWhere((meal) => meal.userId == productModel.sellerId).userId;
      username =
          y.firstWhere((meal) => meal.userId == productModel.sellerId).name;
    }

    Get.put(CheckoutViewModel());
    Get.put(ProfileViewModel());
    return Scaffold(
      // extendBodyBehindAppBar: true,
      
      // backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 196,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            productModel.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: CustomText(
                                maxLines: 2,
                                text: productModel.name,
                                fontFamily: 'Amazon',
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 20),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Price',
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  CustomText(
                                    text: '\$${productModel.price}',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedShapeInfo(
                              title: 'Size: ',
                              content: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  text: productModel.sized,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            RoundedShapeInfo(
                              title: 'Color',
                              content: Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: productModel.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: 'Sold by :',
                                  fontSize: 18,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (userId.length > 5) {
                                      Get.to(SellerInfo(id: userId));
                                    }
                                  },
                                  child: Text(username,
                                      style: username == 'Shopify'
                                          ? const TextStyle(
                                              color: Colors.black,
                                              // decoration: TextDecoration.underline,
                                              fontSize: 18,
                                              fontFamily: 'Amazon',
                                            )
                                          : const TextStyle(
                                              fontFamily: 'Amazon',
                                              color: Colors.blue,
                                              // decoration: TextDecoration.underline,
                                              fontSize: 18,
                                            )),
                                )
                              ],
                            ),
                            GetBuilder<FavoritesviewModel>(
                                init: FavoritesviewModel(),
                                builder: ((controller) => Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 0, right: 0),
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          controller
                                              .addProduct(FavortiesProdcutModel(
                                            name: productModel.name,
                                            image: productModel.image,
                                            price: productModel.price,
                                            productId: productModel.productId,
                                            // category: productModel.category,
                                          ));
                                        },
                                        backgroundColor: primaryColor,
                                        child: const Icon(LineIcons.heart),
                                      ),
                                    ))),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: 'Details',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: productModel.det,
                          fontSize: 14,
                          height: 2,
                          maxLines: 100,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: 'You might also like ',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _listViewProducts(),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: 'Reviews ',
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                                            fontSize: 16,
                                            color: Colors.black87)),
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
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 20, top: 9),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black12, width: 2),
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
                                      Get.find<ProfileViewModel>()
                                          .currentUser!
                                          .pic;
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
                                                name:
                                                    Get.find<ProfileViewModel>()
                                                        .currentUser!
                                                        .name,
                                                pic:
                                                    Get.find<ProfileViewModel>()
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
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    height: 50,
                    width: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: primaryColor,
                      ),
                    ),
                    child: GetBuilder<CartViewModel>(
                      init: CartViewModel(),
                      builder: ((controller) => IconButton(
                            icon: SvgPicture.asset(
                              "assets/images/add_to_cart.svg",
                              color: primaryColor,
                            ),
                            onPressed: () {
                              controller.addProduct(CartProductModel(
                                name: productModel.name,
                                image: productModel.image,
                                price: productModel.price,
                                productId: productModel.productId,
                                // category: productModel.category,
                                quantity: 1,
                              ));
                            },
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: GetBuilder<CartViewModel>(
                        init: Get.put(CartViewModel()),
                        builder: (controller) => FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: primaryColor,
                          onPressed: () {
                            controller.addProduct(CartProductModel(
                              name: productModel.name,
                              image: productModel.image,
                              price: productModel.price,
                              productId: productModel.productId,
                              // category: productModel.category,
                              quantity: 1,
                            ));
                            Get.to(CheckoutView());
                          },
                          child: Text(
                            "Buy  Now".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listViewProducts() {
    List<ProductModel> products = Get.find<HomeViewModel>()
        .products
        .where((meal) => meal.category == cat)
        .toList();
    products.removeWhere((element) => element.productId == widget.id);
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

class RoundedShapeInfo extends StatelessWidget {
  final String title;
  final Widget content;

  const RoundedShapeInfo({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            content,
          ],
        ),
      ),
    );
  }
}

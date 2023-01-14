// import 'dart:html';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/view/review_view.dart';
import 'package:myshopp/view/search_view.dart';
import 'package:myshopp/view/testtt.dart';
import 'package:tflite/tflite.dart';

import '../constants.dart';
import '../core/viewmodel/cart_view_model.dart';
import '../core/viewmodel/home_view_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/error.dart';
import '../widgets/error.dart';
import '../widgets/speach.dart';
import 'category_products_view.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List? _outputs;
  XFile? _image;

  bool _loading = false;
  String text = 'Press the button and start speaking';
  // one dev to role the all
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  bool isListening = false;
  String x = '';
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => controller.isloading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
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
                        'Shopify',
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontFamily: 'Baumans'),
                      )),
                    ),
                  ),
                ),
              ),
              backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
              body: SingleChildScrollView(
                child: Column(
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
                              color: const Color.fromRGBO(246, 246, 246, 1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 10, left: 16, right: 16, bottom: 14),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Row(children: [
                                      _searchTextFormField(),
                                      AvatarGlow(
                                        animate: isListening,
                                        endRadius: 25,
                                        glowColor: primaryColor,
                                        child: IconButton(
                                          icon: Icon(
                                              isListening
                                                  ? Icons.mic
                                                  : Icons.mic_none,
                                              size: 30),
                                          onPressed: toggleRecording,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.camera_alt_outlined,
                                            size: 27),
                                        onPressed: () {
                                          Get.dialog(AlertDialog(
                                            title: CustomText(
                                              text: 'Choose option',
                                              fontSize: 20,
                                              color: Colors.blue,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Divider(
                                                  height: 1,
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    try {
                                                      await pickImage('cam');
                                                      if (_outputs![0]
                                                              ["label"] ==
                                                          'null') {
                                                        Get.to(Errorr());
                                                      }
                                                      print(_outputs![0]
                                                          ["label"]);
                                                      print(
                                                          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

                                                      // setState(() {
                                                      //   _outputs!.clear();
                                                      // });
                                                      // Get.back();
                                                    } catch (error) {
                                                      customErrorScreen();
                                                    }
                                                  },
                                                  title: CustomText(
                                                    text: 'Camera',
                                                  ),
                                                  leading: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    try {
                                                      await pickImage('c');
                                                      print(_outputs![0]
                                                          ["label"]);
                                                      print(
                                                          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                                      Get.back();

                                                      // Get.back();
                                                    } catch (error) {
                                                      customErrorScreen();
                                                    }
                                                  },
                                                  title: CustomText(
                                                    text: 'Gallery',
                                                  ),
                                                  leading: const Icon(
                                                    Icons
                                                        .photo_library_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                        },
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      // Get.to(Test());
                                    }),
                                    child: CustomText(
                                      text: 'Categories',
                                      fontFamily: 'Baumans',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _listViewCategory(),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(Get.find<CartViewModel>()
                                              .cartProductModel
                                              .length);
                                        },
                                        child: CustomText(
                                          text: "Best Selling ",
                                          fontFamily: 'Baumans',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(CategoryProductsView(
                                              categoryName: 'Best Selling',
                                              products: controller.products));
                                        },
                                        child: CustomText(
                                          text: "See all ",
                                          fontSize: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  _listViewProducts(),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.63,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        // color: Colors.grey.shade200,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black87),
          hintText: "What are you looking for?",
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.length >= 1) {
            Get.to(SearchView(value));
          }
        },
      ),
    );
  }

  Widget _listViewCategory() {
    return GetBuilder<HomeViewModel>(
      builder: ((controller) => Container(
            height: 100,
            child: ListView.separated(
              itemCount: controller.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(CategoryProductsView(
                      categoryName: controller.categories[index].name,
                      products: controller.products
                          .where((product) =>
                              product.category ==
                              controller.categories[index].name.toLowerCase())
                          .toList(),
                    ));
                  },
                  child: Column(
                    children: [
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.network(
                                controller.categories[index].image),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: controller.categories[index].name,
                        fontSize: 12,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
            ),
          )),
    );
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return ProductDetailView(
                //       productModel: controller.products[index]);
                // },),);

                Get.to(ProductDetailView(
                    id: controller.products[index].productId));
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
                        color: Colors.transparent,
                      ),
                      height: 220,
                      width: 164,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          controller.products[index].image,
                          fit: BoxFit.cover,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: (controller.products[index].rating ==
                                    null ||
                                controller.products[index].reviews == null ||
                                controller.products[index].reviews!.length <
                                    1 ||
                                controller.products[index].rating!.length < 1 ||
                                controller.products[index].reviews == '0' ||
                                controller.products[index].rating == '0')
                            ? 0
                            : double.parse(controller.products[index].rating!) /
                                int.parse(controller.products[index].reviews!),

                        maxRating: 5,
                        size: 20,
                        // alignment: Alignment.center,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        color: Colors.black45,
                        text: controller.products[index].reviews!.isEmpty
                            ? '(0)'
                            : '(${controller.products[index].reviews})',
                      )
                    ]),
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      fontWeight: FontWeight.bold,
                      text: '\$${controller.products[index].price}',
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

  pickImage(String x) async {
    if (x == 'cam') {
      try {
        final ImagePicker _picker = ImagePicker(); // <--- here
        XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image == null) return null;
        setState(() {
          _loading = true;
          _image = image;
        });
        classifyImage(image);
      } catch (Exception) {
        print("error with images ");
      }
    }
    try {
      final ImagePicker _picker = ImagePicker(); // <--- here
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      setState(() {
        _loading = true;
        _image = image;
      });
      classifyImage(image);
    } catch (Exception) {
      print("error");
    }
  }

  classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 10,
      threshold: 0.9,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
      if (_outputs!.length == 0) {
        Get.to(Errorr());
      } else {
        if (_outputs![0]["label"] == null ||
            _outputs![0]["label"] == '' ||
            _outputs![0]["label"] == 0) {
          Get.to(Errorr());
        } else if (_outputs![0]["label"] != null) {
          x = _outputs![0]["label"];
          Get.to(SearchView(x));
        }
      }
    });
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          this.text = text;
          print(text);
        }),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.to(SearchView(text));
            });
          }
        },
      );
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}

customErrorScreen() {
  ErrorWidget.builder = (errorDetails) {
    return (Errorr());
  };
}

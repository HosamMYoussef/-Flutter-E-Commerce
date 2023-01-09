import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/home_view.dart';

import '../core/viewmodel/SellViewModel.dart';
import '../core/viewmodel/cart_view_model.dart';
import '../core/viewmodel/checkoutview_model.dart';
import '../core/viewmodel/profile_viewmodel.dart';
import '../core/viewmodel/selectImage_viewmodel.dart';
import '../widgets/Custom_text_form_feild.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class AuctionSell extends StatefulWidget {
  @override
  State<AuctionSell> createState() => _AuctionSellState();
}

class _AuctionSellState extends State<AuctionSell> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLoadingg = false;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileViewModel());
    late String? sellerId = Get.find<ProfileViewModel>().currentUser!.userId;
    Get.put(SellModel());
    return GetBuilder<SelectImageViewModel>(
      init: SelectImageViewModel(),
      builder: (controller) => Scaffold(
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
                  'Start auction',
                  style: TextStyle(
                      fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
                )),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, bottom: 24, top: 0),
                  child: Card(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            title: ' Auction Name',
                            hintText: '',
                            validatorFn: (value) {
                              if (value!.isEmpty || value.length < 1)
                                return 'Please enter valid name.';
                            },
                            onSavedFn: (value) {
                              Get.find<SellModel>().aname = value;
                              Get.find<SellModel>().asellerId = sellerId;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              CustomTextFormField(
                                title: 'Category ',
                                hintText: 'Ex Devices',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 3)
                                    return 'Please enter valid Valid Category.';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().acategory = value;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Type ',
                                hintText: 'Ex laptop',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 3)
                                    return 'Please enter valid Valid Category.';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().atype = value;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Auction Description',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter longer description .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().adescription = value;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Auction condition',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter Size .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().acondition = value;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              CustomTextFormField(
                                title: 'Auction Start  Price',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter Auction Price .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().aprice = value;
                                },
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // CustomTextFormField(
                              //   title: 'Auction Color',
                              //   hintText: '',
                              //   validatorFn: (value) {
                              //     if (value!.isEmpty)
                              //       return 'Please enter Auction Color .';
                              //   },
                              //   onSavedFn: (value) {
                              //     Get.find<SellModel>().color = value;
                              //   },
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              GetBuilder<SelectImageViewModel>(
                                  init: SelectImageViewModel(),
                                  builder: (controller) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Auction Image'),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                AlertDialog(
                                                  title: CustomText(
                                                    text: 'Choose option',
                                                    fontSize: 20,
                                                    color: Colors.blue,
                                                  ),
                                                  content: _isLoadingg
                                                      ? const CircularProgressIndicator()
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Divider(
                                                              height: 1,
                                                            ),
                                                            ListTile(
                                                              onTap: () async {
                                                                try {
                                                                  setState(() {
                                                                    _isLoadingg =
                                                                        true;
                                                                  });
                                                                  await controller
                                                                      .camera();
                                                                  Get.find<SellModel>()
                                                                          .aimage =
                                                                      controller
                                                                          .imageURL;
                                                                  setState(() {
                                                                    _isLoadingg =
                                                                        false;
                                                                  });
                                                                  Get.back();
                                                                } catch (error) {
                                                                  Get.back();
                                                                }
                                                              },
                                                              title: CustomText(
                                                                text: 'Camera',
                                                              ),
                                                              leading:
                                                                  const Icon(
                                                                Icons.camera_alt_outlined,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            const Divider(
                                                              height: 1,
                                                            ),
                                                            ListTile(
                                                              onTap: () async {
                                                                try {
                                                                  setState(() {
                                                                    _isLoadingg =
                                                                        true;
                                                                  });
                                                                  await controller
                                                                      .gallery();
                                                                  Get.find<SellModel>()
                                                                          .aimage =
                                                                      controller
                                                                          .imageURL;
                                                                  setState(() {
                                                                    _isLoadingg =
                                                                        false;
                                                                  });
                                                                  Get.back();

                                                                  // Get.back();
                                                                } catch (error) {
                                                                  Get.back();
                                                                }
                                                              },
                                                              title: CustomText(
                                                                text: 'Gallery',
                                                              ),
                                                              leading:
                                                                  const Icon(
                                                                Icons
                                                                    .photo_library,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            _isLoadingg
                                                                ? const CircularProgressIndicator()
                                                                : SizedBox(
                                                                    height: 20),
                                                          ],
                                                        ),
                                                ),
                                              );
                                            },
                                            child: const Text('Select Image'),
                                          ),
                                        ],
                                      )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  text: 'Upload',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      // try {
                                      //   await controller
                                      //       .uploadImageToFirebase();
                                      //   Get.find<SellModel>().image =
                                      //       'controller.picUrl';
                                      //   print(controller.picUrl);
                                      // } catch (e) {
                                      //   Get.find<ProfileViewModel>().picUrl =
                                      //       Get.find<ProfileViewModel>()
                                      //           .currentUser!
                                      //           .pic;
                                      // }

                                      _formKey.currentState!.save();
                                       await Get.find<SellModel>()
                                           .addAuctionsToFireStore();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

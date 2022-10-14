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
import 'package:myshopp/core/viewmodel/SellViewModel.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/home_view.dart';

import '../core/viewmodel/cart_view_model.dart';
import '../core/viewmodel/checkoutview_model.dart';
import '../core/viewmodel/profile_viewmodel.dart';
import '../core/viewmodel/selectImage_viewmodel.dart';
import '../widgets/Custom_text_form_feild.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class SellView extends StatefulWidget {
  @override
  State<SellView> createState() => _SellViewState();
}

class _SellViewState extends State<SellView> {
  File? _imageFile;
  late String imageURL;
  Future gallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(image!.path));
    String x = await uploadTask.then((res) async {
      return res.ref.getDownloadURL();
    });
    print(x);

    setState(() {
      _imageFile = File(image.path);
      imageURL = x;
    });
  }

  Future camera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(image!.path));
    String x = await uploadTask.then((res) async {
      return res.ref.getDownloadURL();
    });
    // print(x);

    setState(() {
      _imageFile = File(image.path);
      imageURL = x;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Get.put(SellModel());
    return GetBuilder<SelectImageViewModel>(
      init: SelectImageViewModel(),
      builder: (controller) => Scaffold(
        body: Column(
          children: [
            Container(
              height: 100,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    CustomText(
                      text: 'Sell Prodcuts',
                      fontSize: 20,
                      alignment: Alignment.center,
                    ),
                    Container(
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
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
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            title: ' Product Name',
                            hintText: '',
                            validatorFn: (value) {
                              if (value!.isEmpty || value.length < 1)
                                return 'Please enter valid name.';
                            },
                            onSavedFn: (value) {
                              Get.find<SellModel>().name = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              CustomTextFormField(
                                title: 'Category ',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 3)
                                    return 'Please enter valid Valid Category.';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().category = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Product Size',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter Size .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().sized = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Product details',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter product details .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().detail = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Product Price',
                                hintText: '',
                                keyboardType: TextInputType.number,
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter Product Price .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().price = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Product Color',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter Product Color .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().det = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                title: 'Product Description',
                                hintText: '',
                                validatorFn: (value) {
                                  if (value!.isEmpty)
                                    return 'Please enter longer description .';
                                },
                                onSavedFn: (value) {
                                  Get.find<SellModel>().description = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // GetBuilder<SelectImageViewModel>(
                              //   init: SelectImageViewModel(),
                              // builder: (controller) =>
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Product Image'),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.dialog(
                                        AlertDialog(
                                          title: CustomText(
                                            text: 'Choose option',
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  try {
                                                    await controller
                                                        .cameraImage();
                                                    Get.back();
                                                  } catch (error) {
                                                    Get.back();
                                                  }
                                                },
                                                title: CustomText(
                                                  text: 'Camera',
                                                ),
                                                leading: Icon(
                                                  Icons.camera,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  try {
                                                    await gallery();
                                                    Get.find<SellModel>()
                                                        .image = imageURL;

                                                    Get.back();
                                                  } catch (error) {
                                                    Get.back();
                                                  }
                                                },
                                                title: CustomText(
                                                  text: 'Gallery',
                                                ),
                                                leading: Icon(
                                                  Icons.photo_library,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Select Image'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _isLoading
                              ? CircularProgressIndicator()
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
                                          .addProductsToFireStore();
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../core/viewmodel/selectImage_viewmodel.dart';
import '../../core/viewmodel/profile_viewmodel.dart';
import '../../widgets/Custom_text_form_feild.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../review_view.dart';
// import '../widgets/custom_text.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _imageFile;
  late String imageURL;
  @override
  Widget build(BuildContext context) {
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

    Get.put(ProfileViewModel());
    var currentUser = Get.find<ProfileViewModel>().currentUser;

    String _loginMethod =
        FirebaseAuth.instance.currentUser!.providerData[0].providerId;
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            // shadow: const BoxShadow(
            //   color: Colors.white,
            //   offset: Offset(4, 4),
            //   blurRadius: 4,
            //   spreadRadius: 8,
            // ),
            clipper: CustomLoginShapeClipper4(),
            child: Container(
              color: primaryColor.withOpacity(0.5),
            ),
          ),
          ClipPath(
            // shadow: const BoxShadow(
            //   color: Colors.white,
            //   offset: Offset(4, 4),
            //   blurRadius: 4,
            //   spreadRadius: 8,
            // ),
            clipper: CustomLoginShapeClipper5(),
            child: Container(
              color: primaryColor,
            ),
          ),
          Column(
            children: [
              Container(
                height: 130,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                        text: 'Edit Profile',
                        fontSize: 20,
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder<SelectImageViewModel>(
                init: SelectImageViewModel(),
                builder: (controller) => Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16, left: 16, bottom: 24),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          AssetImage('assets/images/prof.png'),
                                      foregroundImage:
                                          currentUser!.pic != 'default'
                                              ? NetworkImage(currentUser.pic)
                                              : null),
                                  SizedBox(
                                    width: 40,
                                  ),
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
                                                    await camera();
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
                              SizedBox(
                                height: 38,
                              ),
                              CustomTextFormField(
                                title: 'Name',
                                hintText: Get.find<ProfileViewModel>()
                                    .currentUser!
                                    .name,
                                initialValue: Get.find<ProfileViewModel>()
                                    .currentUser!
                                    .name,
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 4)
                                    return 'Please enter valid name.';
                                },
                                onSavedFn: (value) {
                                  Get.find<ProfileViewModel>().name = value;
                                },
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Column(
                                children: [
                                  CustomTextFormField(
                                    title: 'Email',
                                    hintText: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .email,
                                    initialValue: Get.find<ProfileViewModel>()
                                        .currentUser!
                                        .email,
                                    keyboardType: TextInputType.emailAddress,
                                    validatorFn: (value) {
                                      if (value!.isEmpty)
                                        return 'Please enter valid email address.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().email =
                                          value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  CustomTextFormField(
                                    title: 'Password',
                                    hintText: '*********',
                                    obscureText: true,
                                    validatorFn: (value) {
                                      if (value!.isEmpty || value.length < 6)
                                        return 'Please enter valid password with at least 6 characters.';
                                    },
                                    onSavedFn: (value) {
                                      Get.find<ProfileViewModel>().password =
                                          value;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : CustomButton(
                                      text: 'SUBMIT',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            await controller
                                                .uploadImageToFirebase();
                                            Get.find<ProfileViewModel>()
                                                .picUrl = imageURL;
                                          } catch (e) {
                                            Get.find<ProfileViewModel>()
                                                    .picUrl =
                                                Get.find<ProfileViewModel>()
                                                    .currentUser!
                                                    .pic;
                                          }
                                          _formKey.currentState!.save();
                                          await Get.find<ProfileViewModel>()
                                              .updateCurrentUser();
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/widgets/Custom_text_form_feild.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../../constants.dart';
import '../../widgets/custom_button_social.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 16, bottom: 30,),
                onPressed: () {
                  Get.off(LoginView());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32,
            right: 16,
            left: 16,bottom:44 ,
          ),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Sign Up',
                          fontSize: 30,
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        CustomTextFormField (
                          title: 'Name',
                          hintText: 'Hosam Youssef',
                          onSavedFn: (value) {
                            controller.name = value!;
                          },
                          validatorFn: (value) {
                            if (value == null) {
                              print('ERROR');
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField (
                          title: 'Email',
                          hintText: 'hosamyoussef@gmail.com',
                          onSavedFn: (value) {
                            controller.email = value!;
                          },
                          validatorFn: (value) {
                            if (value == null) {
                              print('ERROR');
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField (
                          title: 'Password',
                          hintText: '*******',
                          onSavedFn: (value) {
                            controller.password = value!;
                          },
                          validatorFn: (value) {
                            if (value == null) {
                              print('ERROR');
                            }
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: () {
                              _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                               controller.CreateAccountWithEmailAndPassword();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myshopp/view/auth/register_view.dart';
import '../../widgets/Custom_text_form_feild.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_button_social.dart';
import '../../widgets/custom_text.dart';

class LoginView extends GetWidget<AuthViewModel> {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            top: 20,
            bottom: 42,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Welcome',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(RegisterView());
                              },
                              child: CustomText(
                                text: 'SignUp',
                                fontSize: 18,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Sign in to Continue',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 48,
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
                        CustomTextFormField(
                            title: 'Password',
                            hintText: '********',
                            obscureText: true,
                            validatorFn: (value) {
                              if (value!.isEmpty)
                                return 'Password is incorrect';
                            },
                            onSavedFn: (value) {
                              controller.password = value!;
                            },
                          ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomText(
                          text: 'Forget Password ?',
                          fontSize: 14,
                          alignment: Alignment.centerRight,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'SIGN IN',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              controller.signInWithEmailAndPassword();
                            }
                          },
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomText(
                          alignment: Alignment.center,
                          text: '-OR-',
                          fontSize: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomButttonSocial(
                            onPressedFn: (() {
                              // controller.facebookSignInMethod();
                            }),
                            text: "Sign In with Facebook",
                            image: 'assets/images/facebook.png',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomButttonSocial(
                            text: "Sign In with Google",
                            image: 'assets/images/google.png',
                            onPressedFn: () {
                              controller.googleSignInMethod();
                            },
                          ),
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

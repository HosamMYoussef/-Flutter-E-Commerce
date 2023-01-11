import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/auth/register_view.dart';

import '../../constants.dart';
import '../../core/viewmodel/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool  obscureTextt = true;
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthViewModel>(
        init: Get.put(AuthViewModel()),
        builder: (controller) => Scaffold(
              backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: SizedBox(),
                            ),
                            const Text(
                              'Shopify',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Baumans',
                                fontSize: 26,
                              ),
                            ),
                            Container(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20, left: 20.0),
                                child: Text('Welcome \n back!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 42)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 60,
                                  width: 400,
                                  // color: Colors.white,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        print('ERROR');
                                      }
                                    },
                                    onSaved: (value) {
                                      controller.email = value!;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '  Enter your email address',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 150, 150),
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 60,
                                  width: 400,
                                  // color: Colors.white,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Password is incorrect';
                                    },
                                    onSaved: (value) {
                                      controller.password = value!;
                                    },
                                    decoration: InputDecoration(
                                      hintText: '  Enter Your Password',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 150, 150),
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock_outlined),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscureTextt = !obscureTextt;
                                            print(obscureTextt);
                                          });
                                        },
                                        child: Icon(obscureTextt
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                    ),
                                    obscureText: obscureTextt,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 240.0),
                                child: Text(
                                  'Forget password?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 52,
                                  width: 238,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        controller.signInWithEmailAndPassword();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      primary: primaryColor,
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don’t have an account yet ?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 150, 150),
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(RegisterView());
                                    },
                                    child: const Text(
                                      ' sign up',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.googleSignInMethod();
                                    },
                                    child: Container(
                                      height: 52,
                                      width: 92,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Image.asset(
                                          'assets/images/google.png'),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 35,
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {},
                                  //   child: Container(
                                  //     height: 52,
                                  //     width: 92,
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius:
                                  //             BorderRadius.circular(13)),
                                  //     child: Image.asset(
                                  //         'assets/images/facebook.png'),
                                  //   ),
                                  // ),
                                ],
                              )
                            ]),
                      )
                    ]),
              ),
            ));
  }
}

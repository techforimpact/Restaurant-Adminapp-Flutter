import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/custom_text.dart';
import '../constants/style.dart';
import '../controllers/general_controller.dart';
import '../controllers/login_controller.dart';
import '../models/style.dart';
import 'constants.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  // final Function onSignUpSelected;
  //
  // LogIn({required this.onSignUpSelected});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool? obscure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<LoginLogic>(
      builder: (_loginLogic) {
        return Padding(
          padding: EdgeInsets.all(size.height > 770
              ? 64
              : size.height > 670
                  ? 32
                  : 16),
          child: Center(
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: size.height *
                    (size.height > 770
                        ? 0.7
                        : size.height > 670
                            ? 0.8
                            : 0.9),
                width: 500,
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOG IN",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Container(
                              width: 30,
                              child: Divider(
                                color: kPrimaryColor,
                                thickness: 2,
                              ),
                            ),

                            const SizedBox(
                              height: 32,
                            ),

                            TextFormField(
                              controller: _loginLogic.emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field Required';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Enter Valid Email';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            const SizedBox(
                              height: 32,
                            ),

                            TextFormField(
                              controller: _loginLogic.passwordController,
                              obscureText: obscure!,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      obscure = !obscure!;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.lock_outline,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Row(
                                //   children: [
                                //     Checkbox(
                                //         value: true, onChanged: (value) {}),
                                //     CustomText(
                                //       text: "Remember Me",
                                //     ),
                                //   ],
                                // ),
                                InkWell(
                                  onTap: () {
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: "admin@bookabite.app")
                                        .then((_) {
                                      Get.snackbar(
                                          "link has been sent to your email for password reset",
                                          '');
                                    }).catchError((error) {
                                      Get.snackbar(
                                          error.message.toString(), '');
                                      log(error.message.toString());
                                    });
                                  },
                                  child: CustomText(
                                      text: "Forgot password?", color: active),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            const SizedBox(
                              height: 64,
                            ),

                            InkWell(
                              onTap: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  Get.find<GeneralController>()
                                      .updateFormLoader(true);
                                  Get.find<GeneralController>()
                                      .firebaseAuthentication
                                      .signInWithEmailAndPassword();
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: deepOrange,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: deepOrange.withOpacity(0.2),
                                      spreadRadius: 4,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child:
                                      Get.find<GeneralController>().formLoader!
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              'Log in',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                            //actionButton("Log In"),

                            const SizedBox(
                              height: 32,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "You do not have an account?",
                            //       style: TextStyle(
                            //         color: Colors.grey,
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 8,
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         widget.onSignUpSelected();
                            //       },
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             "Sign Up",
                            //             style: TextStyle(
                            //               color: deepOrange,
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: 8,
                            //           ),
                            //           Icon(
                            //             Icons.arrow_forward,
                            //             color: deepOrange,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

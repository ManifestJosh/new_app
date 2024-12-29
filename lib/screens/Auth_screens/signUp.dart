import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/checkbox_controler.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/screens/Auth_screens/login.dart';
import 'package:new_app/service/Auth.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final CheckboxController checkboxController = Get.put(CheckboxController());
  final Auth auth = Auth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Padding(
        padding: AppSpacing.horizontalLg,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Hey there,',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    15.verticalSpace,
                    Text(
                      'Create an Account',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    20.verticalSpace,
                    Textbox(
                        icon: Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.grey,
                          size: 18.sp,
                        ),
                        hintText: 'Email',
                        width: 315,
                        height: 48,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: emailcontroller),
                    10.verticalSpace,
                    Passwordbox(
                      hintText: 'Password',
                      width: 315,
                      height: 48,
                      controller: passwordController,
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey,
                        size: 18.sp,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 18.sp,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    10.verticalSpace,
                    FittedBox(
                      child: Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                                activeColor: MyColors.secondary_color,
                                side: const BorderSide(color: Colors.grey),
                                value: checkboxController.isChecked.value,
                                onChanged: (newValue) {
                                  checkboxController.toggleCheckbox();
                                });
                          }),
                          Text(
                            'By continuing you accept our Privacy Policy and \nTerm of Use',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    150.verticalSpace,
                    Buttons(
                        width: 315,
                        height: 60,
                        text: 'Register',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final user = await auth.signUp(
                                emailcontroller.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (user != null) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('uid', user.uid);

                                Get.snackbar(
                                  'Success',
                                  'Account created Successfully',
                                  backgroundColor: MyColors.primary_color,
                                  colorText: Colors.white,
                                );
                                Get.off(() => AuthPage());
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                e.toString(),
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                            }
                          }
                        }),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 20.w,
                            endIndent: 5.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          'Or',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Expanded(
                            child: Divider(
                          indent: 10.w,
                          endIndent: 20.w,
                          color: Colors.grey.shade300,
                        )),
                      ],
                    ),
                    25.verticalSpace,
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grey_color),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.r))),
                      child: Image.asset(
                        'assets/images/logos/google.png',
                        width: 10.w,
                        height: 10.h,
                      ),
                    ),
                    30.verticalSpace,
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have an account?',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: MyColors.secondary_color),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const LoginPage());
                            })
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/signup.dart';
import 'package:new_app/screens/Auth_screens/welcomepage.dart';
import 'package:new_app/service/Auth.dart';
import 'package:new_app/utils/my_colors.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/Buttons.dart';
import '../../widgets/text_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Auth _auth = Auth();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Form(
              key: formkey,
              child: Column(children: [
                30.verticalSpace,
                Text(
                  'Hey there,',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                15.verticalSpace,
                Text(
                  'Welcome Back',
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
                  height: 58,
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                10.verticalSpace,
                Passwordbox(
                  hintText: 'Password',
                  width: 315,
                  height: 58,
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
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Forgot your password? ',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline),
                  ),
                ),
                200.verticalSpace,
                Buttons(
                    icon: SvgPicture.asset(
                      'assets/icons/login_icons.svg',
                      color: MyColors.ScreenBackground_color,
                    ),
                    width: 315,
                    height: 60,
                    text: 'Login',
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          final user = await _auth.signIn(
                            emailcontroller.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (user != null) {
                            Get.snackbar(
                              'Success',
                              'LogIn Successfully',
                              backgroundColor: MyColors.primary_color,
                              colorText: Colors.white,
                            );
                            await authController.fetchUserData(user.uid);
                            String firstName = authController.name.value;
                            Get.offAll(() => Welcomepage2(
                                firstName: firstName, uid: user.uid));
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
                      borderRadius: BorderRadius.all(Radius.circular(16.r))),
                  child: Image.asset(
                    'assets/images/logos/google.png',
                    width: 10.w,
                    height: 10.h,
                  ),
                ),
                30.verticalSpace,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Dont have an account?',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.secondary_color,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignUpPage());
                            })
                    ],
                  ),
                )
              ]),
            ),
          ),
        )));
  }
}

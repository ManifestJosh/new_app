import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/welcomepage.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';

import '../widgets/Buttons.dart';
import '../widgets/text_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
        padding: EdgeInsets.all(18.0),
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
              height: 48,
              controller: emailcontroller),
          10.verticalSpace,
          Textbox(
            hintText: 'Password',
            obscureText: true,
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
          ),
          Text(
            'Forgot your password? ',
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline),
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
              onTap: () {
                Get.off(() => Welcomepage2());
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
                      color: MyColors.secondary_color),
                )
              ],
            ),
          )
        ]),
      ),
    )));
  }
}

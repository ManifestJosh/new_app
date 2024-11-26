import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/checkbox_controler.dart';
import 'package:new_app/screens/auth_page.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final CheckboxController checkboxController = Get.put(CheckboxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: AppSpacing.horizontalLg,
        child: Center(
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
                  Icons.person_2_outlined,
                  color: Colors.grey,
                  size: 18.sp,
                ),
                hintText: 'First Name',
                width: 315,
                height: 48,
                controller: first_name,
              ),
              10.verticalSpace,
              Textbox(
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                  hintText: 'Last Name',
                  width: 315,
                  height: 48,
                  controller: last_name),
              10.verticalSpace,
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
                  onTap: () {
                    Get.off(() => AuthPage());
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
                )
              ]))
            ],
          ),
        ),
      )),
    );
  }
}

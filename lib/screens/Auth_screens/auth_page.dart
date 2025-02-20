import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_app/screens/Auth_screens/login.dart';

import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';
import 'package:new_app/widgets/widgets.dart';

import '../../service/Auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  final TextEditingController gendercontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();
  final TextEditingController heightcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.09.sh,
              child: Stack(
                children: [
                  Positioned(
                      top: 0.08.sh,
                      left: 0.03.sw,
                      child: SvgPicture.asset(
                        'assets/vectors/profilevector.svg',
                        width: 349.w,
                        height: 263.h,
                      )),
                  Positioned(
                      top: 0.08.sh,
                      left: 0.18.sw,
                      child: Image.asset(
                        'assets/images/welcome_images/w1.png',
                        width: 235.w,
                        height: 259.63.h,
                      )),
                  Positioned(
                    top: 0.43.sh,
                    left: 50.w,
                    right: 50.w,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Let’s complete your profile',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          10.verticalSpace,
                          Text(
                            'It will help us to know more about you!',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: MyColors.grey_color),
                          ),
                          30.verticalSpace,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
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
                            controller: last_name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Last Name';
                              }
                              return null;
                            },
                          ),
                          10.verticalSpace,
                          DropdownList(
                            namecontroller: gendercontroller,
                            items: ['Male', 'Female'],
                            hinttext: 'Choose Gender',
                            width: 315,
                            height: 55,
                            icon: Icon(
                              Icons.people_outline,
                              color: Colors.grey,
                              size: 18.sp,
                            ),
                          ),
                          10.verticalSpace,
                          Textbox(
                            hintText: 'Date of Birth',
                            width: 315,
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.grey,
                              size: 18.sp,
                            ),
                            height: 55,
                            controller: dobcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Date of Birth';
                              }
                              return null;
                            },
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              Textbox(
                                hintText: 'Your Weight',
                                width: 232,
                                height: 55,
                                controller: weightcontroller,
                                icon: Icon(
                                  Icons.scale_outlined,
                                  color: Colors.grey,
                                  size: 18.sp,
                                ),
                              ),
                              15.horizontalSpace,
                              box1(
                                width: 48,
                                height: 48,
                                data: 'KG',
                              )
                            ],
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              Textbox(
                                hintText: 'Your Height',
                                width: 232,
                                height: 55,
                                controller: heightcontroller,
                                icon: Icon(
                                  Icons.compare_arrows,
                                  color: Colors.grey,
                                  size: 18.sp,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your height';
                                  }
                                  return null;
                                },
                              ),
                              15.horizontalSpace,
                              box1(
                                width: 48,
                                height: 48,
                                data: 'M',
                              )
                            ],
                          ),
                          20.verticalSpace,
                          Buttons(
                            width: 315,
                            height: 60,
                            text: 'Next',
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                DateFormat formatter = DateFormat('yyyy-MM-dd');
                                DateTime dob =
                                    formatter.parse(dobcontroller.text.trim());
                                double weight =
                                    double.parse(weightcontroller.text.trim());
                                double height =
                                    double.parse(heightcontroller.text.trim());
                                if (dob.isAfter(DateTime.now())) {
                                  Get.snackbar(
                                    'Error',
                                    'Please enter a valid date of birth',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }
                                Get.dialog(
                                  const Center(
                                      child: CircularProgressIndicator(
                                    color: MyColors.secondary_color,
                                  )),
                                  barrierDismissible: false,
                                );
                                _auth.userDetails(
                                  first_name.text.trim(),
                                  last_name.text.trim(),
                                  gendercontroller.text.trim(),
                                  dob,
                                  weight,
                                  height,
                                );
                                Get.back();
                                Get.off(() => const LoginPage());
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.ScreenBackground_color,
                              size: 18.sp,
                            ),
                            isIconBeforeText: false,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

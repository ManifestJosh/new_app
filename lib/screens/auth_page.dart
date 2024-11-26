import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/login.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';
import 'package:new_app/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController gendercontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();
  final TextEditingController heightcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    controller: dobcontroller),
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
                    ),
                    15.horizontalSpace,
                    box1(
                      width: 48,
                      height: 48,
                      data: 'CM',
                    )
                  ],
                ),
                20.verticalSpace,
                Buttons(
                  width: 315,
                  height: 60,
                  text: 'Next',
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: MyColors.ScreenBackground_color,
                    size: 18.sp,
                  ),
                  isIconBeforeText: false,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class box1 extends StatelessWidget {
  const box1({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });
  final double width;
  final double height;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [MyColors.secondary_colors, MyColors.secondary_color],
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: MyColors.ScreenBackground_color),
        ),
      ),
    );
  }
}

class box2 extends StatelessWidget {
  const box2({
    super.key,
    required this.width,
    required this.height,
    required this.widget,
    this.color,
    this.gradient,
  });
  final double width;
  final double height;
  final Gradient? gradient;
  final Widget widget;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Center(
        child: widget,
      ),
    );
  }
}

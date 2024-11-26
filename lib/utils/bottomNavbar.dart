import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:new_app/controllers/bottom_navController.dart';
import 'package:new_app/screens/HomePage/homepage.dart';
import 'package:new_app/utils/my_colors.dart';

import '../screens/ActivityPage/activity_page.dart';
import '../screens/ProfilePage/profile.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final BottomNavcontroller controller = Get.put(BottomNavcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            return IndexedStack(
              index: controller.selectedIndex.value,
              children: const [
                Homepage(),
                ActivityPage(),
                Profile(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: MyColors.secondary_color,
          currentIndex: controller.selectedIndex.value,
          backgroundColor: MyColors.ScreenBackground_color,
          onTap: controller.changeTabIndex,
          items: [
            BottomNavigationBarItem(
                activeIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.house,
                      size: 24.sp,
                    ),
                    5.verticalSpace,
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.secondary_color),
                    )
                  ],
                ),
                label: '',
                icon: Icon(
                  LineAwesomeIcons.home_solid,
                  size: 24.sp,
                )),
            BottomNavigationBarItem(
                activeIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.chartPie,
                      size: 24.sp,
                    ),
                    5.verticalSpace,
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.secondary_color),
                    )
                  ],
                ),
                label: '',
                icon: Icon(
                  LineAwesomeIcons.chart_pie_solid,
                  size: 24.sp,
                )),
            BottomNavigationBarItem(
                activeIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.userLarge,
                      size: 24.sp,
                    ),
                    5.verticalSpace,
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.secondary_color),
                    )
                  ],
                ),
                label: '',
                icon: Icon(
                  LineAwesomeIcons.user,
                  size: 24.sp,
                )),
          ],
        );
      }),
    );
  }
}

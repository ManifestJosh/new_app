import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../controllers/bottom_navController.dart';
import '../screens/main_app_screens/HomePage/homepage.dart';
import '../screens/main_app_screens/ActivityPage/activity_page.dart';
import '../screens/main_app_screens/ProfilePage/profile.dart';
import '../utils/my_colors.dart';

class BottomNavbar extends StatefulWidget {
  final String uid;
  const BottomNavbar({super.key, required this.uid});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final BottomNavcontroller controller = Get.put(BottomNavcontroller());

  @override
  Widget build(BuildContext context) {
    // Calculate the height of the bottom navbar

    return Scaffold(
      // Remove SafeArea to allow full screen scrolling
      body: Stack(
        children: [
          // Content that scrolls behind the navbar
          Positioned(
            child: Obx(
              () {
                return IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    Homepage(uid: widget.uid),
                    ActivityPage(),
                    Profile(),
                  ],
                );
              },
            ),
          ),

          // Floating Bottom Navbar
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h,
            child: Center(
              child: Container(
                width: 0.7.sw, // 70% of screen width
                height: 0.09.sh, // Adjust height as needed
                decoration: BoxDecoration(
                  color: MyColors.ScreenBackground_color,
                  border: Border.all(color: MyColors.secondary_color, width: 2),
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(() {
                  return BottomNavigationBar(
                    elevation: 0, // Remove default elevation
                    selectedItemColor: MyColors.secondary_color,
                    currentIndex: controller.selectedIndex.value,
                    backgroundColor:
                        Colors.transparent, // Make background transparent
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/auth_controller.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/service/api_service.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/homepage_widgets.dart';
import 'workout.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthController authController = Get.put(AuthController());
  final WorkoutService workoutService = WorkoutService();

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  Future<void> initializeUserData() async {
    String userId = await getUid();
    if (userId.isNotEmpty) {
      authController.fetchUserData(userId);
    } else {
      print("User ID is empty. Cannot fetch user data.");
    }
  }

  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs);
    return prefs.getString('uid') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.horizontalLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              name_n_notification_tab(authController: authController),
              30.verticalSpace,
              Bmi_box(
                authController: authController,
              ),
              30.verticalSpace,
              const Target_box(),
              20.verticalSpace,
              Text(
                'What Do You Want to Train',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              15.verticalSpace,
              Container(
                  padding: AppSpacing.allMd,
                  width: 349.w,
                  height: 132.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      color: Colors.blue.shade50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WorkOut for different \nBodyPart",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      20.verticalSpace,
                      InkWell(
                        onTap: () {
                          Get.to(() => WorkOut());
                        },
                        child: Container(
                          width: 94.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              'View More',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 10.sp,
                                  color: MyColors.primary_color),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

class Target_box extends StatelessWidget {
  const Target_box({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allMd,
      width: 349.w,
      height: 57.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          color: Colors.blue.shade50),
      child: Row(
        children: [
          Text(
            "Today's Target",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          130.horizontalSpace,
          Buttons3(width: 68.w, height: 28.h, text: 'Check', onTap: () {})
        ],
      ),
    );
  }
}

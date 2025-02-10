import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/auth_controller.dart';
import 'package:new_app/controllers/bottom_navController.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/service/api_service.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/bottomNavbar.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/homepage_widgets.dart';
import 'workout.dart';

class Homepage extends StatefulWidget {
  final String uid;
  const Homepage({super.key, required this.uid});

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
    String userId = widget.uid;
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
              ExerciseBox(
                onTap: () {
                  Get.to(() => WorkOut(
                        title: 'WorkOut for different BodyPart',
                      ));
                },
                text: "WorkOut for different \nBodyPart",
                image: 'assets/images/bodybuilder.png',
              ),
              20.verticalSpace,
              ExerciseBox(
                  onTap: () {
                    Get.to(() => WorkOut(
                          title: 'Workout Your Muscles',
                        ));
                  },
                  text: "Workout Your Muscles",
                  image: 'assets/images/muscular_man.png'),
              20.verticalSpace,
              ExerciseBox(
                  onTap: () {
                    Get.to(() => WorkOut(
                          title: 'Workout with Equipments',
                        ));
                  },
                  text: "Workout with Equipments",
                  image: 'assets/images/equipments.png'),
              120.verticalSpace,
            ],
          ),
        ),
      )),
    );
  }
}

class ExerciseBox extends StatelessWidget {
  const ExerciseBox({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
  });
  final VoidCallback onTap;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppSpacing.allMd,
        width: double.infinity,
        height: 0.17.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.r)),
            color: Colors.blue.shade50),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 94.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
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
            ),
            Spacer(),
            Image.asset(
              image,
              fit: BoxFit.contain,
            )
          ],
        ));
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
      width: double.infinity,
      height: 0.06.sh,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          color: Colors.blue.shade50),
      child: Row(
        children: [
          Text(
            "Today's Target",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Spacer(),
          Buttons3(
              width: 68.w,
              height: 28.h,
              text: 'Check',
              onTap: () {
                BottomNavcontroller bottomNavcontroller = Get.find();
                bottomNavcontroller.changeTabIndex(1);
              })
        ],
      ),
    );
  }
}

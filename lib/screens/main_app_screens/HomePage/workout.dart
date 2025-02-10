import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/screens/main_app_screens/HomePage/workout_controller.dart';
import 'package:new_app/service/api_service.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';

import '../../../widgets/widgets.dart';
import 'workoutPage.dart';

class WorkOut extends StatefulWidget {
  const WorkOut({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<WorkOut> createState() => _WorkOutState();
}

class _WorkOutState extends State<WorkOut> {
  final WorkoutController workoutController = Get.put(WorkoutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.ScreenBackground_color,
        appBar: AppBar(
          backgroundColor: MyColors.ScreenBackground_color,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.0.w),
            child: box2(
              width: 32,
              height: 32,
              widget: Icon(
                Icons.arrow_back_ios,
                size: 16.sp,
              ),
              color: MyColors.border_color,
              onTap: () {
                Get.back();
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            box2(
              width: 32,
              height: 32,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 4.sp,
                  ),
                  Icon(
                    Icons.circle,
                    size: 4.sp,
                  ),
                ],
              ),
              color: MyColors.border_color,
              onTap: () {},
            ),
            20.horizontalSpace
          ],
        ),
        body: widget.title == "WorkOut for different BodyPart"
            ? SafeArea(
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Your Ultimate Workout Guide! 💪🔥",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    10.verticalSpace,
                    Text(
                      "Get ready to transform your fitness journey with targeted workouts for every muscle group! Whether you're looking to build strength, tone up, or improve endurance, we've got you covered.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      maxLines: 4,
                      overflow: TextOverflow.visible,
                    ),
                    20.verticalSpace,
                    Text(
                      "Below are the exercises for various body part, so get in and let's do this !!!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                    Obx(() {
                      if (workoutController.isLoading.value) {
                        return Center(
                          child: SpinKitFadingCircle(
                            size: 50.0.sp,
                            color: MyColors.primary_color2,
                          ),
                        );
                      }
                      if (workoutController.exercise.isEmpty) {
                        return Center(
                          child: Text(
                            'No body Part Found',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                            itemCount: workoutController.exercise.length,
                            itemBuilder: (context, index) {
                              final bodyPart =
                                  workoutController.exercise[index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  bodyPart,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 18.sp,
                                ),
                                onTap: () {
                                  Get.to(() => Workoutpage(bodyPart: bodyPart));
                                },
                              );
                            }),
                      );
                    })
                  ],
                ),
              ))
            : widget.title == 'Workout Your Muscles'
                ? SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Muscle Mastery! 💪',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          10.verticalSpace,
                          Text(
                            "Get ready to unlock your strength and sculpt your body with our muscle-focused workouts! Whether you're aiming to build power, increase endurance, or enhance definition, our targeted exercises will help you achieve your fitness goals. From explosive strength training to controlled muscle isolation, every session is designed to push your limits and maximize results.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                            maxLines: 4,
                            overflow: TextOverflow.visible,
                          ),
                          10.verticalSpace,
                          Text(
                            "Stay consistent, stay motivated, and let’s get stronger together! 🔥🏋️‍♂️",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                            maxLines: 4,
                            overflow: TextOverflow.visible,
                          )
                        ],
                      ),
                    ),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Your Ultimate Workout with Equipment! 💪🔥',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.left,
                          ),
                          10.verticalSpace,
                          Text(
                            "Get ready to take your fitness journey to the next level! Whether you're lifting weights, using resistance bands, or working with machines, incorporating equipment into your workouts can help you build strength, improve endurance, and achieve your goals faster.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                          ),
                          10.verticalSpace,
                          Text(
                            "Let's gear up, stay motivated, and make every rep count! 🏋️‍♂️🏋️‍♀️✨",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                            overflow: TextOverflow.visible,
                          )
                        ],
                      ),
                    ),
                  ));
  }
}

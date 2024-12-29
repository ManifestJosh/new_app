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
  });

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
            'WorkOut for different BodyPart',
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
        body: SafeArea(
            child: Column(
          children: [
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
                      final bodyPart = workoutController.exercise[index];
                      return Padding(
                        padding: AppSpacing.horizontalSm,
                        child: ListTile(
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
                        ),
                      );
                    }),
              );
            })
          ],
        )));
  }
}

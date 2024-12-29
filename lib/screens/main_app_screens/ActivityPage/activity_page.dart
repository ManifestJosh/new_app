import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';

import '../../../widgets/widgets.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Activity Tracking',
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
          child: Padding(
        padding: AppSpacing.horizontalMd,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Container(
                padding: AppSpacing.allMd,
                width: 349.w,
                height: 149.h,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(24.r))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Today's Target",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        150.horizontalSpace,
                        box2(
                          width: 32,
                          height: 32,
                          widget: Icon(
                            Icons.add,
                            color: MyColors.ScreenBackground_color,
                            size: 16.sp,
                          ),
                          gradient: MyColors.button_gradient,
                          onTap: () {},
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        box_4(
                          widget: Row(
                            children: [
                              Image.asset(
                                'assets/images/waterbottle.png',
                                width: 25.w,
                                height: 34.h,
                              ),
                              10.horizontalSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '8L',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.primary_color2),
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    'Water Intake',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        50.horizontalSpace,
                        box_4(
                          widget: Column(
                            children: [],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              50.verticalSpace,
              Row(
                children: [
                  Text(
                    'Latest Activity',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'See more',
                        style: Theme.of(context).textTheme.displayMedium,
                      ))
                ],
              ),
              20.verticalSpace,
              SizedBox(
                  height: 600.h,
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, int) {
                        return Column(
                          children: [
                            Container(
                              width: 349.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                  color: MyColors.ScreenBackground_color,
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.light_grey,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r))),
                              child: ListTile(
                                leading: CircleAvatar(),
                                title: Text(
                                  'data',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                subtitle: Text(
                                  'data',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: Icon(
                                  Icons.info,
                                  color: Colors.grey,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                            15.verticalSpace
                          ],
                        );
                      }))
            ],
          ),
        ),
      )),
    );
  }
}

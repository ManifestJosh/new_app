import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/screens/auth_page.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';

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
        leading: box2(
            width: 32,
            height: 32,
            widget: Icon(
              Icons.arrow_back_ios,
              size: 16.sp,
            ),
            color: MyColors.border_color),
        centerTitle: true,
        title: Text(
          'Activity Tracker ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          box2(
              width: 32,
              height: 32,
              widget: Row(
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
              color: MyColors.border_color),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: AppSpacing.horizontalMd,
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
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
      )),
    );
  }
}

class box_4 extends StatelessWidget {
  const box_4({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allSm,
      width: 130.w,
      height: 60.h,
      decoration: BoxDecoration(
          color: MyColors.ScreenBackground_color,
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: widget,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:new_app/controllers/auth_controller.dart';
import 'package:new_app/screens/main_app_screens/ProfilePage/edit_page.dart';
import 'package:new_app/screens/main_app_screens/ProfilePage/notification.dart';
import 'package:new_app/screens/main_app_screens/ProfilePage/profile_controller.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/widgets/Buttons.dart';

import '../../../controllers/switch_controller.dart';
import '../../../utils/my_colors.dart';
import '../../../widgets/widgets.dart';
import '../../Auth_screens/auth_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  final SwitchController switchController = Get.put(SwitchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.ScreenBackground_color,
        centerTitle: true,
        title: Text(
          'Profile ',
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
            onTap: () {
              Get.back();
            },
          ),
          20.horizontalSpace
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: AppSpacing.horizontalLg,
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    '${authController.name} ${authController.last_name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Buttons3(
                      width: 83,
                      height: 30,
                      text: 'Edit',
                      onTap: () {
                        Get.to(() => EditPage());
                      })
                ],
              ),
              30.verticalSpace,
              Row(
                children: [
                  box_5(
                    data: '${authController.height.value} m',
                    data2: 'Height',
                  ),
                  20.horizontalSpace,
                  box_5(
                      data: '${authController.weight.value} Kg',
                      data2: 'Weight'),
                  20.horizontalSpace,
                  box_5(data: '${authController.age.value}yo', data2: 'Age')
                ],
              ),
              30.verticalSpace,
              Box_6(
                width: 350.w,
                height: 175.h,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    10.verticalSpace,
                    ListTile(
                        leading: Icon(
                          Icons.notifications_outlined,
                          color: MyColors.primary_color,
                          size: 20.sp,
                        ),
                        title: Text(
                          'Pop-Up Notification',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Obx(() {
                          return CupertinoSwitch(
                            activeColor: MyColors.secondary_color,
                            value:
                                switchController.isNotificationsEnabled.value,
                            onChanged: (value) =>
                                switchController.toggleNotifications(value),
                          );
                        })),
                    10.verticalSpace,
                    ListTile(
                      leading: Icon(
                        LineAwesomeIcons.access_alarms,
                        color: MyColors.primary_color,
                        size: 20.sp,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              TimeOfDay selectedTime = TimeOfDay.now();

                              return SizedBox(
                                width: double.infinity,
                                height: 0.3.sh,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0.h, left: 16.w, right: 16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Set Daily Reminder',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      10.verticalSpace,
                                      InkWell(
                                        onTap: () async {
                                          final TimeOfDay? picked =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: selectedTime,
                                          );
                                          if (picked != null) {
                                            selectedTime = picked;
                                            // Schedule the notification
                                            final notificationService =
                                                PushNotificationService();
                                            await notificationService
                                                .initialize();
                                            await notificationService
                                                .scheduleWorkoutReminder(
                                              hour: picked.hour,
                                              minute: picked.minute,
                                            );
                                            setState(() {
                                              selectedTime = picked;
                                            });
                                            Get.snackbar('Reminder Set',
                                                'Reminder Set ${picked.format(context)}');
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.h, horizontal: 16.w),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Select Time'),
                                              Icon(Icons.access_time),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      title: Text(
                        'Set Daily Reminder',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    )
                  ],
                ),
              ),
              30.verticalSpace,
              Box_6(
                width: 350.w,
                height: 260.h,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    10.verticalSpace,
                    listbuilder(
                      icon: profileController.icons,
                      text: profileController.text,
                      icons: Icons.arrow_forward_ios,
                      onTap: profileController.onTap,
                    )
                  ],
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      )),
    );
  }
}

class listbuilder extends StatelessWidget {
  const listbuilder({
    super.key,
    required this.icon,
    required this.text,
    required this.icons,
    required this.onTap,
  });
  final List icon;
  final List text;
  final IconData icons;
  final List<Function()> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: icon.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                icon[index],
                color: MyColors.primary_color,
                size: 20.sp,
              ),
              onTap: onTap[index],
              title: Text(
                text[index],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: Icon(
                icons,
                size: 18.sp,
                color: MyColors.grey_color,
              ),
            );
          }),
    );
  }
}

class Box_6 extends StatelessWidget {
  const Box_6({
    super.key,
    required this.widget,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppSpacing.allMd,
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: MyColors.light_grey,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ],
            color: MyColors.ScreenBackground_color,
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            )),
        child: widget);
  }
}

class box_5 extends StatelessWidget {
  const box_5({
    super.key,
    required this.data,
    required this.data2,
  });
  final String data;
  final String data2;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      height: 65.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: MyColors.light_grey,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
        color: MyColors.ScreenBackground_color,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data,
            style: TextStyle(
                color: MyColors.primary_color,
                fontFamily: 'poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            data2,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}

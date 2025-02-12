import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/task_controller.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/widgets.dart';

class MissedActivities extends StatefulWidget {
  const MissedActivities({super.key});

  @override
  State<MissedActivities> createState() => _MissedActivitiesState();
}

class _MissedActivitiesState extends State<MissedActivities> {
  final TaskController taskController = Get.put(TaskController());
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
          'Missed Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Obx(() {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: taskController.missedTasks.length,
            itemBuilder: (context, index) {
              final task = taskController.missedTasks[index];
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
                        borderRadius: BorderRadius.all(Radius.circular(16.r))),
                    child: ListTile(
                      title: Text(
                        task['title'] ?? 'No title',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        task['description'] ?? 'No description',
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
            });
      }),
    );
  }
}

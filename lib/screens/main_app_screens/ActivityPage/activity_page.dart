import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/checkbox_controler.dart';
import 'package:new_app/controllers/task_controller.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/screens/main_app_screens/ActivityPage/latest_activity.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';

import '../../../service/Auth.dart';
import '../../../widgets/widgets.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final Auth _auth = Auth();
  final TaskController taskController = Get.put(TaskController());
  final CheckboxController checkboxController = Get.put(CheckboxController());
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
                height: 159.h,
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
                        Spacer(),
                        box2(
                          width: 32,
                          height: 32,
                          widget: Icon(
                            Icons.add,
                            color: MyColors.ScreenBackground_color,
                            size: 16.sp,
                          ),
                          gradient: MyColors.button_gradient,
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return taskWidget(
                                      titlecontroller: titlecontroller,
                                      descriptioncontroller:
                                          descriptioncontroller,
                                      auth: _auth);
                                });
                          },
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: taskController.dailyTasks.isEmpty
                            ? Center(
                                child: Text(
                                  'No Target for today',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              )
                            : Row(
                                children: taskController.dailyTasks.map((task) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.all(32.sp),
                                                title: SingleChildScrollView(
                                                  child: Text(
                                                    task['title'] ?? 'No Title',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Obx(() {
                                                              return Checkbox
                                                                  .adaptive(
                                                                value:
                                                                    checkboxController
                                                                        .isChecked
                                                                        .value,
                                                                onChanged:
                                                                    (newValue) {
                                                                  checkboxController
                                                                      .toggleCheckbox();
                                                                },
                                                              );
                                                            }),
                                                            Expanded(
                                                              child: Text(
                                                                task['description'] ??
                                                                    'No Description',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        20.verticalSpace,
                                                        Buttons3(
                                                          width:
                                                              double.maxFinite,
                                                          height: 40,
                                                          text: 'Done',
                                                          onTap: () async {
                                                            _auth.saveDoneTask(
                                                              task['id'],
                                                              task['title'],
                                                              task[
                                                                  'description'],
                                                            );
                                                            Get.back();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: box_4(
                                        widget: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task['title'] ?? 'No Title',
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            5.verticalSpace,
                                            Text(
                                              task['description'] ??
                                                  'No Description',
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                      );
                    }),
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
                      onPressed: () {
                        Get.to(() => LatestActivity());
                      },
                      child: Text(
                        'See more',
                        style: Theme.of(context).textTheme.displayMedium,
                      ))
                ],
              ),
              20.verticalSpace,
              Obx(() {
                if (taskController.doneTasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No Activity found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 470.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskController.doneTasks.length,
                      itemBuilder: (context, index) {
                        final task = taskController.doneTasks[index];
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
                                    blurRadius: 5.r,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.r)),
                              ),
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
                            15.verticalSpace,
                          ],
                        );
                      },
                    ),
                  );
                }
              }),
              20.verticalSpace,
              Row(
                children: [
                  Text(
                    'Missed Activities',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Icon(
                    Icons.close,
                    size: 24.sp,
                    color: Colors.red,
                    weight: 10,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.to(() => LatestActivity());
                      },
                      child: Text(
                        'See more',
                        style: Theme.of(context).textTheme.displayMedium,
                      ))
                ],
              ),
              15.verticalSpace,
              Obx(() {
                if (taskController.doneTasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No Activity found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 500.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskController
                          .missedTasks.length, // Ensure dynamic count
                      itemBuilder: (context, index) {
                        final task = taskController.missedTasks[index];
                        return Column(
                          children: [
                            Dismissible(
                              key: Key(task['docId']),
                              onDismissed: (direction) async {
                                await FirebaseFirestore.instance
                                    .collection('missedTasks')
                                    .doc(task['id'])
                                    .delete();

                                taskController.missedTasks.removeAt(index);
                              },
                              child: Container(
                                width: 349.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  color: MyColors.ScreenBackground_color,
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.light_grey,
                                      blurRadius: 5.r,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r)),
                                ),
                                child: ListTile(
                                  title: Text(
                                    task['title'] ?? 'No title',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  subtitle: Text(
                                    task['description'] ?? 'No description',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  trailing: Icon(
                                    Icons.delete_forever,
                                    color: Colors.grey,
                                    size: 19.sp,
                                  ),
                                ),
                              ),
                            ),
                            15.verticalSpace,
                          ],
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      )),
    );
  }
}

class taskWidget extends StatelessWidget {
  const taskWidget({
    super.key,
    required this.titlecontroller,
    required this.descriptioncontroller,
    required Auth auth,
  }) : _auth = auth;

  final TextEditingController titlecontroller;
  final TextEditingController descriptioncontroller;
  final Auth _auth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: 0.4.sh,
        child: Padding(
          padding: EdgeInsets.only(top: 16.0.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Set Today's Target",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 18.sp,
                      ))
                ],
              ),
              30.verticalSpace,
              Text(
                'Task Title',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Textbox(
                  hintText: 'Task Title',
                  width: 300,
                  height: 40,
                  controller: titlecontroller),
              20.verticalSpace,
              Text(
                'Task Description',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Textbox(
                  hintText: 'Task Description',
                  width: 300,
                  height: 40,
                  controller: descriptioncontroller),
              30.verticalSpace,
              Center(
                child: Buttons2(
                    width: 300,
                    height: 40,
                    text: 'Save',
                    onTap: () {
                      final title = titlecontroller.text;
                      final description = descriptioncontroller.text;
                      if (title.isNotEmpty && description.isNotEmpty) {
                        _auth.saveTask(title, description);
                        TaskController taskController =
                            Get.find<TaskController>();
                        taskController.fetchDailyTasks();
                        Get.back();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Title and description cannot be empty.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0.sp,
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

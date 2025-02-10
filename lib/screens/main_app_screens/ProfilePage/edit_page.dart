import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/widgets/text_box.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/Buttons.dart';
import '../../../widgets/widgets.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
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
          'Edit Details',
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
          20.horizontalSpace,
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            Text(
              'First Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Textbox(
              icon: Icon(
                Icons.person_2_outlined,
                color: Colors.grey,
                size: 18.sp,
              ),
              hintText: 'First Name',
              width: 315,
              height: 48,
              controller: firstNameController,
            ),
            30.verticalSpace,
            Text(
              'Last Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Textbox(
              icon: Icon(
                Icons.person_outline,
                color: Colors.grey,
                size: 18.sp,
              ),
              hintText: 'Last Name',
              width: 315,
              height: 48,
              controller: lastNameController,
            ),
            30.verticalSpace,
            Text(
              'Weight',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              children: [
                Textbox(
                  hintText: 'Your Weight',
                  width: 232,
                  height: 55,
                  controller: weightController,
                  icon: Icon(
                    Icons.scale_outlined,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                ),
                15.horizontalSpace,
                box1(
                  width: 48,
                  height: 48,
                  data: 'KG',
                )
              ],
            ),
            30.verticalSpace,
            Text(
              'Height',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              children: [
                Textbox(
                  hintText: 'Your Height',
                  width: 232,
                  height: 55,
                  controller: heightController,
                  icon: Icon(
                    Icons.compare_arrows,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                ),
                15.horizontalSpace,
                box1(
                  width: 48,
                  height: 48,
                  data: 'M',
                ),
              ],
            ),
            80.verticalSpace,
            Center(
                child:
                    Buttons(width: 315, height: 60, text: 'Save', onTap: () {}))
          ],
        ),
      )),
    );
  }
}

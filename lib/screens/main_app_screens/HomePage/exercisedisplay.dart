import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_app/controllers/stepController.dart';
import 'package:new_app/widgets/Buttons.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/widgets.dart';

class ExerciseDisplay extends StatefulWidget {
  final String gifUrl;
  final dynamic bodyPartExercise;
  const ExerciseDisplay(
      {super.key, required this.gifUrl, required this.bodyPartExercise});

  @override
  State<ExerciseDisplay> createState() => _ExerciseDisplayState();
}

class _ExerciseDisplayState extends State<ExerciseDisplay> {
  final RxDouble containerTopPosition = 0.3.sh.obs;
  final ScrollController _scrollController = ScrollController();

  final Steppercontroller steppercontroller = Get.put(Steppercontroller());

  @override
  void initState() {
    super.initState();
    // Listen to the scroll changes
    _scrollController.addListener(() {
      // Update the position based on scroll offset
      containerTopPosition.value = 0.4.sh - _scrollController.offset / 1000;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.ScreenBackground_color,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              leading: SizedBox.shrink(),
              backgroundColor: MyColors.ScreenBackground_color,
              expandedHeight: 415.h,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.network(
                      widget.gifUrl,
                      width: MediaQuery.of(context).size.width,
                      height: 415.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          height: 150.h,
                        );
                      },
                    ),
                    Positioned(
                      top: 15.h,
                      left: 20.w,
                      child: box2(
                        width: 32,
                        height: 32,
                        widget: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.ScreenBackground_color,
                            size: 12.sp,
                          ),
                        ),
                        color: MyColors.primary_color,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      right: 20.w,
                      child: box2(
                        width: 32,
                        height: 32,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: MyColors.ScreenBackground_color,
                              size: 4.sp,
                            ),
                            Icon(
                              Icons.circle,
                              color: MyColors.ScreenBackground_color,
                              size: 4.sp,
                            ),
                          ],
                        ),
                        color: MyColors.primary_color,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main content
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toBeginningOfSentenceCase(
                          widget.bodyPartExercise['name'])!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    10.verticalSpace,
                    Text(
                      'Target: ${(widget.bodyPartExercise['targetMuscles'] as List<dynamic>).join(', ')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    10.verticalSpace,
                    Text(
                      'Equipments: ${(widget.bodyPartExercise['equipments'] as List<dynamic>).join(', ')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'How to do it',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        Text(
                          '${widget.bodyPartExercise['instructions'].length} steps',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Obx(() {
                      return Stepper(
                        physics: const NeverScrollableScrollPhysics(),
                        currentStep: steppercontroller.currentstep.value,
                        onStepContinue: () {
                          steppercontroller.nextstep(
                              widget.bodyPartExercise['instructions'].length);
                        },
                        onStepCancel: () {
                          steppercontroller.previousstep();
                        },
                        steps: (widget.bodyPartExercise['instructions']
                                as List<dynamic>)
                            .asMap()
                            .entries
                            .map((entry) {
                          return Step(
                            title: Text('Step ${entry.key + 1}'),
                            content: Text(entry.value),
                            state:
                                steppercontroller.currentstep.value > entry.key
                                    ? StepState.complete
                                    : StepState.indexed,
                            isActive: steppercontroller.currentstep.value ==
                                entry.key,
                          );
                        }).toList(),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return steppercontroller.currentstep.value ==
                                  widget.bodyPartExercise['instructions']
                                          .length -
                                      1
                              ? const SizedBox.shrink()
                              : Row(
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: details.onStepContinue,
                                      child: const Text('Continue'),
                                    ),
                                    TextButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                );
                        },
                      );
                    }),
                    60.verticalSpace,
                    Center(
                      child: Buttons(
                        width: 320,
                        height: 60,
                        text: 'Save',
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

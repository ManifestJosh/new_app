import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/main_app_screens/HomePage/workout_controller.dart';
import 'package:new_app/utils/my_colors.dart';

import 'exercisedisplay.dart';

class Workoutpage extends StatefulWidget {
  final dynamic bodyPart;
  const Workoutpage({super.key, this.bodyPart});

  @override
  State<Workoutpage> createState() => _WorkoutpageState();
}

class _WorkoutpageState extends State<Workoutpage> {
  final WorkoutController _controller = Get.put(WorkoutController());
  @override
  void initState() {
    super.initState();
    _controller.bodyPartName.value = widget.bodyPart;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchBodyPartExercise(widget.bodyPart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bodyPart,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(
                  child: SpinKitDancingSquare(
                    color: MyColors.primary_color2,
                    size: 70.sp,
                  ),
                );
              }
              if (_controller.fetchExercises.isEmpty) {
                return Center(
                  child: Text(
                    'No Exercise for this Body Part',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return Expanded(
                  child: ListView.builder(
                      itemCount: _controller.fetchExercises.length,
                      itemBuilder: (context, index) {
                        final bodyPartExercise =
                            _controller.fetchExercises[index];
                        final gifUrl = bodyPartExercise['gifUrl'];
                        return ListTile(
                          title: Text(
                            bodyPartExercise['name'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Row(
                            children: [
                              Image.network(
                                gifUrl,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => ExerciseDisplay(gifUrl: gifUrl));
                          },
                        );
                      }));
            })
          ],
        ),
      ),
    );
  }
}

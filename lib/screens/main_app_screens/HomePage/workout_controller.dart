import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/service/api_service.dart';

class WorkoutController extends GetxController {
  final WorkoutService workoutService = WorkoutService();
  var exercise = <dynamic>[].obs;
  var muscleExercise = <dynamic>[].obs;
  var fetchExercises = <dynamic>[].obs;
  var isLoading = true.obs;
  Rx<String?> bodyPartName = Rx<String?>(null);
  Rx<String?> muscleName = Rx<String?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchBodyPart();
    ever(bodyPartName, (value) {
      if (value != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          fetchBodyPartExercise(value);
        });
      }
    });
  }

  Future<void> fetchedMuscles() async {
    try {
      isLoading(true);
      final fetchedMuscles = await workoutService.getMuscles();
      muscleExercise.assignAll(fetchedMuscles);
      if (fetchedMuscles.isNotEmpty) {
        muscleName.value = fetchedMuscles.first;
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBodyPart() async {
    try {
      isLoading(true);
      final fetchedBodyPart = await workoutService.getBodypart();
      exercise.assignAll(fetchedBodyPart);
      if (fetchedBodyPart.isNotEmpty) {
        bodyPartName.value = fetchedBodyPart.first;
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBodyPartExercise(String bodyPartName) async {
    try {
      isLoading(true);
      final fetchedexercise =
          await workoutService.getBodyWeightExercise(bodyPartName);
      fetchExercises.assignAll(fetchedexercise);
    } catch (e) {
      print('Error fetching exercises:$e ');
    } finally {
      isLoading(false);
    }
  }
}

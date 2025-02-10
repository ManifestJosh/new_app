import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/Auth.dart';

class TaskController extends GetxController {
  var displayedItemCount = 5.obs;
  final Auth auth = Auth();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var dailyTasks =
      <Map<String, dynamic>>[].obs; // Changed to empty list initialization
  var doneTasks = <Map<String, dynamic>>[].obs;
  var missedTasks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDailyTasks();
    fetchDoneTasks();
    fetchMissedTasks();
  }

  void toggleItemCount() {
    displayedItemCount.value = (displayedItemCount.value == 5) ? 10 : 5;
  }

  // Updated to fetch all daily tasks
  Future<void> fetchDailyTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('tasks')
          .get();

      dailyTasks.value = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      print("Fetched ${dailyTasks.length} daily tasks");
    } catch (e) {
      print("Error fetching daily tasks: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch daily tasks',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchDoneTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('completedTasks')
          .get();

      doneTasks.value = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      print("Fetched ${doneTasks.length} completed tasks");
    } catch (e) {
      print("Error fetching done tasks: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch completed tasks',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> markTaskAsDone(String taskId) async {
    try {
      final userDoc = _firestore.collection('users').doc(auth.currentUser?.uid);

      // Get the task data
      DocumentSnapshot taskSnapshot =
          await userDoc.collection('tasks').doc(taskId).get();

      if (taskSnapshot.exists) {
        Map<String, dynamic> taskData =
            taskSnapshot.data() as Map<String, dynamic>;

        // Add completion timestamp
        taskData['completedAt'] = FieldValue.serverTimestamp();

        // Move task to completedTasks collection
        await userDoc.collection('completedTasks').add(taskData);

        // Remove from tasks collection
        await userDoc.collection('tasks').doc(taskId).delete();

        // Refresh task lists
        await fetchDailyTasks();
        await fetchDoneTasks();

        Get.snackbar(
          'Success',
          'Task marked as complete',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error marking task as done: $e");
      Get.snackbar(
        'Error',
        'Failed to mark task as complete',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> handleExpiredTasks() async {
    try {
      final userDoc = _firestore.collection('users').doc(auth.currentUser?.uid);

      QuerySnapshot querySnapshot = await userDoc.collection('tasks').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> task = doc.data() as Map<String, dynamic>;

        if (task['createdAt'] != null) {
          Timestamp createdAt = task['createdAt'];
          DateTime expiryTime = createdAt.toDate().add(Duration(hours: 24));

          if (DateTime.now().isAfter(expiryTime)) {
            task['expiredAt'] = FieldValue.serverTimestamp();

            await userDoc.collection('missedTasks').add(task);

            // Remove from tasks collection
            await userDoc.collection('tasks').doc(doc.id).delete();
          }
        }
      }

      // Refresh task lists
      await fetchDailyTasks();
      await fetchMissedTasks();
    } catch (e) {
      print("Error handling expired tasks: $e");
      Get.snackbar(
        'Error',
        'Failed to process expired tasks',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchMissedTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('missedTasks')
          .get();

      missedTasks.value = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      print("Fetched ${missedTasks.length} missed tasks");
    } catch (e) {
      print("Error fetching missed tasks: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch missed tasks',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

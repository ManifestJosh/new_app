import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var displayedItemCount = 5.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var dailyTasks = <Map<String, dynamic>>[].obs;
  var doneTasks = <Map<String, dynamic>>[].obs;
  var missedTasks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Fetch tasks immediately after controller is initialized
    fetchDailyTasks();
    fetchDoneTasks();
    fetchMissedTasks();
  }

  void toggleItemCount() {
    displayedItemCount.value = (displayedItemCount.value == 5) ? 10 : 5;
  }

  Future<void> fetchDailyTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();

      dailyTasks.value = querySnapshot.docs.map((doc) {
        return {
          'docId': doc.id, // Add the document ID here
          ...doc.data() as Map<String, dynamic>, // Include the task data
        };
      }).toList();
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  Future<void> fetchDoneTasks() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('donetasks').get();
      doneTasks.value = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching done tasks: $e");
    }
  }

  Future<void> markDoneTasks(String taskId, String doneTaskId) async {
    try {
      // Get the task data
      DocumentSnapshot taskSnapshot =
          await _firestore.collection('tasks').doc(taskId).get();

      if (taskSnapshot.exists) {
        // Move task to `donetasks`
        await _firestore
            .collection('donetasks')
            .doc(doneTaskId)
            .set(taskSnapshot.data() as Map<String, dynamic>);

        // Remove task from `tasks`
        await _firestore.collection('tasks').doc(taskId).delete();
      }
    } catch (e) {
      print("Error marking task as done: $e");
    }
  }

  Future<void> handleExpiredTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> task = doc.data() as Map<String, dynamic>;

        // Check if the task is older than 24 hours
        if (task['completedAt'] != null) {
          Timestamp createdAt = task['completedAt'];
          DateTime expiryTime = createdAt.toDate().add(Duration(hours: 24));

          if (DateTime.now().isAfter(expiryTime)) {
            // Move task to `missedTasks`
            await _firestore.collection('missedTasks').doc(doc.id).set(task);

            // Remove task from `tasks`
            await _firestore.collection('tasks').doc(doc.id).delete();
          }
        }
      }
    } catch (e) {
      print("Error handling expired tasks: $e");
    }
  }

  Future<void> fetchMissedTasks() async {
    try {
      // Fetch missed tasks from Firestore
      QuerySnapshot querySnapshot =
          await _firestore.collection('missedTasks').get();
      missedTasks.value = querySnapshot.docs.map((doc) {
        return {
          'docId': doc.id, // Document ID
          ...doc.data() as Map<String, dynamic>, // Task data
        };
      }).toList();
    } catch (e) {
      print("Error fetching missed tasks: $e");
    }
  }
}

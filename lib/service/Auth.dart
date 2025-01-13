import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/task_controller.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedUp', true);

      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool('isLoggedIn', true);
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> userDetails(String firstName, String lastName, String gender,
      DateTime dob, double weight, double height) async {
    try {
      User? user = currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'Gender': gender,
          'dob': dob,
          'Weight': weight,
          'Height': height,
        });
        Get.snackbar(
          'Successfully Updated',
          'Your details has been uploaded',
          backgroundColor: MyColors.primary_color,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: MyColors.primary_color,
        colorText: Colors.white,
      );
    }
  }

  void saveTask(String title, String description) async {
    try {
      // Validate inputs
      if (title.isEmpty || description.isEmpty) {
        Fluttertoast.showToast(
          msg: "Title and description cannot be empty.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
        return;
      }

      // Get the current user
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        Fluttertoast.showToast(
          msg: "User not logged in.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
        return;
      }

      // Reference to Firestore collection
      CollectionReference tasks = _firestore.collection('tasks');

      // Add task data to Firestore
      await tasks.add({
        'uid': user.uid, // Associate the task with the user
        'title': title,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Notify user of success
      Fluttertoast.showToast(
        msg: "Task added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
      // Show error toast
      Fluttertoast.showToast(
        msg: "Error adding task: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    }
  }

  void saveDoneTask(String taskId, String title, String description) async {
    try {
      // Validate inputs
      if (title.isEmpty || description.isEmpty) {
        Fluttertoast.showToast(
          msg: "Title and description cannot be empty.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
        return;
      }

      // Get the current user
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        Fluttertoast.showToast(
          msg: "User not logged in.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
        return;
      }

      // Reference to Firestore collection
      CollectionReference doneTasks = _firestore.collection('donetasks');
      DocumentReference taskDoc = _firestore.collection('tasks').doc(taskId);
      print("Received taskId: $taskId");

      // Check if the task exists before proceeding
      DocumentSnapshot taskSnapshot = await taskDoc.get();
      if (!taskSnapshot.exists) {
        Fluttertoast.showToast(
          msg: "Task not found.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
        return;
      }

      // Add done task data to Firestore
      await doneTasks.add({
        'uid': user.uid, // Associate the task with the user
        'title': title,
        'description': description,
        'completedAt': FieldValue.serverTimestamp(), // Timestamp for completion
      });

      await taskDoc.delete();
      TaskController taskController = Get.find();
      await taskController.fetchDailyTasks();
      await taskController.fetchDoneTasks();

      // Notify user of success
      Fluttertoast.showToast(
        msg: "Task marked as done successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
      // Show error toast
      Fluttertoast.showToast(
        msg: "Error saving done task: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    }
  }
}

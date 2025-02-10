import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/task_controller.dart';
import 'package:new_app/screens/Auth_screens/login.dart';
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

      // Create user document with initial empty collections
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create subcollections for tasks and completed tasks
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('tasks')
          .doc('placeholder')
          .set({
        'placeholder': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('completedTasks')
          .doc('placeholder')
          .set({
        'placeholder': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedUp', true);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.message}');
    }
    return null;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Get.offAll(() => LoginPage());
      Get.snackbar(
        'Email Sent',
        'Check your email for the password reset link.',
        backgroundColor: MyColors.primary_color,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.message}');
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
        // Update only the profile field in the user document
        await _firestore.collection('users').doc(user.uid).update({
          'profile': {
            'firstName': firstName,
            'lastName': lastName,
            'gender': gender,
            'dob': dob,
            'weight': weight,
            'height': height,
            'lastUpdated': FieldValue.serverTimestamp(),
          }
        });

        Get.snackbar(
          'Successfully Updated',
          'Your profile details have been saved',
          backgroundColor: MyColors.primary_color,
          colorText: Colors.white,
        );

        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          print('Profile updated: ${userDoc.data()}');
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        backgroundColor: MyColors.primary_color,
        colorText: Colors.white,
      );
    }
  }

  void saveTask(String title, String description) async {
    try {
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

      // Store tasks in user-specific subcollection
      CollectionReference userTasks =
          _firestore.collection('users').doc(user.uid).collection('tasks');

      await userTasks.add({
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: "Task added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
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

      // Reference to user-specific collections
      CollectionReference userCompletedTasks = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('completedTasks');

      DocumentReference taskDoc = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId);

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

      await userCompletedTasks.add({
        'title': title,
        'description': description,
        'completedAt': FieldValue.serverTimestamp(),
      });

      await taskDoc.delete();
      TaskController taskController = Get.find();
      await taskController.fetchDailyTasks();
      await taskController.fetchDoneTasks();

      Fluttertoast.showToast(
        msg: "Task marked as done successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } catch (e) {
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

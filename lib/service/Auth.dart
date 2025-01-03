import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}

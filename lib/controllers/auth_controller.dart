import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var name = ''.obs;
  var last_name = ''.obs;
  RxDouble height = 0.0.obs;
  RxDouble weight = 0.0.obs;
  var age = 0.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        // Safely cast data using Map
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        Map<String, dynamic>? profile =
            data['profile'] as Map<String, dynamic>?;

        if (profile != null) {
          name.value = profile['firstName']?.toString() ?? '';
          last_name.value = profile['lastName']?.toString() ?? '';

          // Safely handle numeric values
          if (profile['weight'] != null) {
            weight.value = (profile['weight'] as num).toDouble();
          }

          if (profile['height'] != null) {
            height.value = (profile['height'] as num).toDouble();
          }

          // Handle date
          if (profile['dob'] != null) {
            Timestamp? dobTimestamp = profile['dob'] as Timestamp?;
            if (dobTimestamp != null) {
              DateTime dob = dobTimestamp.toDate();
              calculateAge(dob);
            }
          }

          print('Successfully fetched user data:');
          print('Name: ${name.value}');
          print('Weight: ${weight.value}');
          print('Height: ${height.value}');
        } else {
          print("Profile data is null");
        }
      } else {
        print("No such document!");
      }
    } catch (e) {
      print("Error fetching user data: $e");

      Get.snackbar(
        'Error',
        'Failed to fetch user data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void calculateAge(DateTime dob) {
    DateTime today = DateTime.now();
    int years = today.year - dob.year;
    int months = today.month - dob.month;
    int days = today.day - dob.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
    }
    age.value = years;
    print("Calculated age: ${age.value}");
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AuthController extends GetxController {
  var name = ''.obs;
  var last_name = ''.obs;
  RxDouble height = 0.0.obs;
  RxDouble weight = 0.0.obs;
  var age = 0.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch user data from Firestore
  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        name.value = snapshot['firstName'];
        last_name.value = snapshot['lastName'];
        weight.value = (snapshot['Weight'] as num).toDouble();
        height.value = (snapshot['Height'] as num).toDouble();
        Timestamp dobString = snapshot['dob'];
        DateTime dob = dobString.toDate();
        calculateAge(dob);
        print('Name: ${name.value}');
      } else {
        print("No such document!");
      }
    } catch (e) {
      print("Error fetching user data: $e");
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

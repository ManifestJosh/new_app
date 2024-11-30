import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/login.dart';
import 'package:new_app/screens/Auth_screens/welcome.dart';
import 'package:new_app/utils/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final bool isSignedUp = prefs.getBool('isSignedUp') ?? false;

  await Firebase.initializeApp();
  runApp(MyApp(
    isSignedUp: isSignedUp,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isSignedUp;
  final bool isLoggedIn;
  const MyApp({super.key, required this.isSignedUp, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(395, 830),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: isSignedUp ? LoginPage() : Welcome());
      },
    );
  }
}

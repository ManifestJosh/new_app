import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/main_app_screens/ProfilePage/notification.dart';

class SwitchController extends GetxController {
  var isNotificationsEnabled = false.obs;
  final PushNotificationService _notificationService =
      PushNotificationService();
  late SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    // Load saved notification preference
    isNotificationsEnabled.value =
        _prefs.getBool('notifications_enabled') ?? false;

    // Initialize notifications if they were previously enabled
    if (isNotificationsEnabled.value) {
      await _notificationService.initialize();
    }
  }

  Future<void> toggleNotifications(bool value) async {
    isNotificationsEnabled.value = value;
    await _prefs.setBool('notifications_enabled', value);

    if (value) {
      // Enable notifications
      await _enableNotifications();
    } else {
      // Disable notifications
      await _disableNotifications();
    }
  }

  Future<void> _enableNotifications() async {
    try {
      // Initialize the notification service
      await _notificationService.initialize();

      // Request permissions again in case they were denied
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get new FCM token if needed
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await _prefs.setString('fcmToken', fcmToken);
        // Here you might want to send the token to your server
      }

      Get.snackbar(
        'Notifications Enabled',
        'You will now receive push notifications',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isNotificationsEnabled.value = false;
      await _prefs.setBool('notifications_enabled', false);

      Get.snackbar(
        'Error',
        'Failed to enable notifications. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error enabling notifications: $e');
    }
  }

  Future<void> _disableNotifications() async {
    try {
      // Delete the FCM token
      await FirebaseMessaging.instance.deleteToken();
      await _prefs.remove('fcmToken');

      // Cancel all active notifications
      await FlutterLocalNotificationsPlugin().cancelAll();

      // Unsubscribe from topics if you're using them
      // await FirebaseMessaging.instance.unsubscribeFromTopic('your_topic');

      Get.snackbar(
        'Notifications Disabled',
        'You will no longer receive push notifications',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to disable notifications. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error disabling notifications: $e');
    }
  }

  // Call this when the app is being closed or the controller is being disposed
  @override
  void onClose() {
    super.onClose();
  }
}

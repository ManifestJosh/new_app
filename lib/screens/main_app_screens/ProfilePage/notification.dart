import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:new_app/main.dart';

class NotificationService {
  final firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  NotificationService() {
    _initializeTimezone();
  }

  void _initializeTimezone() {
    try {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.UTC);
    } catch (e) {
      print('Timezone initialization error: $e');
    }
  }

  Future<bool> requestExactAlarmPermission() async {
    try {
      // Check Android version
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfo.androidInfo;

        // Only request permission for Android 12 and above
        if (androidInfo.version.sdkInt >= 31) {
          // Use platform channel to request exact alarm permission
          const platform = MethodChannel('com.example.app/exact_alarms');

          try {
            final result =
                await platform.invokeMethod('requestExactAlarmPermission');
            return result ?? false;
          } on PlatformException catch (e) {
            print('Platform Exception: ${e.message}');
            return false;
          }
        }
      }

      // For other platforms or older Android versions, return true
      return true;
    } catch (e) {
      print('Error checking exact alarm permission: $e');
      return false;
    }
  }

  Future<void> initNotification() async {
    // Request exact alarm permission first
    final hasPermission = await requestExactAlarmPermission();
    if (!hasPermission) {
      print('Exact alarm permission not granted');
      return;
    }

    // Request notification permissions
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    final FCMtoken = await firebaseMessaging.getToken();
    print('FCM Token: $FCMtoken');

    // Initialize local notifications
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        navigatorKey.currentState?.pushNamed('/notificationPage');
      },
    );

    // Schedule daily reminder
    await scheduleDailyReminder();
  }

  Future<void> scheduleDailyReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_reminder',
      'Daily Reminders',
      channelDescription: 'Channel for daily app check reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Use UTC as a fallback
    final now = tz.TZDateTime.now(tz.UTC);
    var scheduledTime = tz.TZDateTime(
      tz.UTC,
      now.year,
      now.month,
      now.day,
      10, // 10 AM
      0, // 0 minutes
    );

    // If it's already past 10 AM, schedule for tomorrow
    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await _localNotifications.zonedSchedule(
      0,
      'Daily Check-in',
      'Don\'t forget to check your app today!',
      scheduledTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    await firebaseMessaging.deleteToken();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('/notificationPage');
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

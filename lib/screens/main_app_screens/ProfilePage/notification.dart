import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SharedPreferences? _prefs;
  String? fcmToken;
  String deviceType = '';
  String deviceId = '';
  static const String workoutChannelId = 'workout_reminder_channel';
  static const String workoutChannelName = 'Workout Reminders';
  static const String workoutChannelDescription =
      'Daily workout reminder notifications';
  static const int workoutNotificationId = 999;

  Future<void> initialize() async {
    tz.initializeTimeZones();
    _prefs = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    await _getDeviceInfo();
    await _initializeLocalNotifications();
    await _requestPermissions();
    await _setupMessageHandlers();
    await _getFCMToken();
  }

  Future<bool> checkAndRequestExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;

    final androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation == null) return false;

    final hasPermission =
        await androidImplementation.requestExactAlarmsPermission();

    if (hasPermission!) {
      // You can add custom dialog/UI handling here if needed
      return false;
    }

    return true;
  }

  Future<void> scheduleWorkoutReminder({
    required int hour,
    required int minute,
    String title = 'Time to Work Out!',
    String body = "Let's get moving! 💪",
  }) async {
    // Check for exact alarm permission first
    if (!await checkAndRequestExactAlarmPermission()) {
      throw PlatformException(
        code: 'exact_alarms_not_permitted',
        message: 'Please grant exact alarm permission in system settings',
      );
    }

    await _prefs!.setInt('workout_reminder_hour', hour);
    await _prefs!.setInt('workout_reminder_minute', minute);
    await _prefs!.setBool('workout_reminder_enabled', true);

    final scheduledTime = _nextInstanceOfTime(hour, minute);

    await _notificationsPlugin.zonedSchedule(
      workoutNotificationId,
      title,
      body,
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          workoutChannelId,
          workoutChannelName,
          channelDescription: workoutChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelWorkoutReminder() async {
    await _notificationsPlugin.cancel(workoutNotificationId);
    await _prefs!.setBool('workout_reminder_enabled', false);
  }

  bool isWorkoutReminderEnabled() {
    return _prefs!.getBool('workout_reminder_enabled') ?? false;
  }

  Map<String, int> getWorkoutReminderTime() {
    return {
      'hour': _prefs!.getInt('workout_reminder_hour') ?? 6,
      'minute': _prefs!.getInt('workout_reminder_minute') ?? 0,
    };
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  Future<void> _requestPermissions() async {
    // Request exact alarm permission for Android
    if (Platform.isAndroid) {
      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final hasExactAlarmPermission =
            await androidImplementation.requestExactAlarmsPermission();
        if (hasExactAlarmPermission!) {
          print('Exact alarms permission not granted');
          return;
        }
      }
    }

    // Firebase messaging permissions
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Local notifications permissions
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
    }
  }

  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      await _notificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      navigatorKey.currentState?.pushNamed('/notificationPage');
      print('Background Message data: ${message.data}');
    }
  }

  Future<void> _handleNotificationTap(NotificationResponse response) async {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      print('Notification tapped with payload: $data');
    }
  }

  Future<void> _getDeviceInfo() async {
    deviceId = _prefs!.getString('deviceId') ?? '';
    deviceType = _prefs!.getString('deviceType') ?? '';

    if (deviceId.isEmpty || deviceType.isEmpty) {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceType = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!;
        deviceType = iosInfo.systemName!;
      }

      await _prefs!.setString('deviceId', deviceId);
      await _prefs!.setString('deviceType', deviceType);
    }
  }

  Future<void> _getFCMToken() async {
    fcmToken = _prefs!.getString('fcmToken');

    if (fcmToken == null) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      await _prefs!.setString('fcmToken', fcmToken!);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      fcmToken = newToken;
      await _prefs!.setString('fcmToken', newToken);
    });
  }
}

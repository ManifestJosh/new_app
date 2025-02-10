import 'package:get/get.dart';
import 'package:new_app/screens/main_app_screens/ProfilePage/notification.dart';

class SwitchController extends GetxController {
  var isturnedOn = false.obs;
  final NotificationService _notificationService = NotificationService();

  void turnOn(value) {
    isturnedOn.value = value;

    if (value) {
      // Activate notifications
      _notificationService.initNotification();
      _notificationService.initPushNotifications();
    } else {
      // Deactivate notifications
      _notificationService.cancelAllNotifications();
    }
  }
}

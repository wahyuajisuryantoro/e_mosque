import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_mosque/model/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel>? _notifications;
  bool _isLoading = false;
  String? _errorMessage;

  List<NotificationModel>? get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  NotificationProvider() {
    getNotifications();
  }

  Future<void> getNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');

      if (username != null) {
        final response = await http.get(
          Uri.parse('http://emasjid.id/api/notifikasi/get_notif.php?username=$username'),
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData['status'] == 'success') {
            _notifications = (jsonData['notifications'] as List)
                .map((notif) => NotificationModel.fromJson(notif))
                .toList();
            _errorMessage = null;
          } else {
            _errorMessage = jsonData['message'];
            print('No notifications found: ${jsonData['message']}');
          }
        } else {
          _errorMessage = 'Failed to load data: Status code ${response.statusCode}';
          print('Server error: ${response.statusCode}');
        }
      } else {
        _errorMessage = "Username not found in session.";
        print('Username not found in SharedPreferences.');
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      print('Error fetching notifications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> checkForWelcomeNotification() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');

      if (username != null) {
        final response = await http.get(
          Uri.parse('http://emasjid.id/api/notifikasi/get_notif.php?username=$username'),
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData['status'] == 'success' && jsonData['notifications'] is List) {
            List notifications = jsonData['notifications'];
            bool welcomeNotificationExists = notifications.any(
              (notif) => notif['name'] == "Selamat Datang di eMasjid.id",
            );
            return welcomeNotificationExists;
          }
        }
      } else {
        print('Username not found in SharedPreferences.');
      }
    } catch (e) {
      print('Error checking welcome notification: $e');
    }
    return false;
  }

  Future<void> postNotification() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');

      if (username != null) {
        final response = await http.post(
          Uri.parse('http://emasjid.id/api/notifikasi/post_notif.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'username': username,
          },
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          print('Response: ${jsonData['message']}');
        } else {
          print('Server error: ${response.statusCode}');
        }
      } else {
        print('Username not found in SharedPreferences.');
      }
    } catch (e) {
      print('Error posting notification: $e');
    }
  }

  Future<void> updateNotificationStatus(int no, String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');

      if (username != null) {
        final response = await http.post(
          Uri.parse('http://emasjid.id/api/notifikasi/update_status_notif.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'no': no.toString(),
            'username': username,
            'status': status,
          },
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData['status'] == 'success') {
            await getNotifications();
          } else {
            _errorMessage = jsonData['message'] ?? 'Failed to update notification status';
          }
        } else {
          _errorMessage = 'Failed to update notification status: Status code ${response.statusCode}';
        }
      } else {
        _errorMessage = "Username not found in session.";
      }
    } catch (e) {
      _errorMessage = 'Failed to update notification status: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    if (_notifications != null) {
      for (var notification in _notifications!) {
        if (notification.status == 'unread') {
          await updateNotificationStatus(notification.no, 'read');
        }
      }
    }
  }
}

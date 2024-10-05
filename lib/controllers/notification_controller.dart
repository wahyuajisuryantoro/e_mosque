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
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      final response = await http.get(
        Uri.parse('http://emasjid.id/api/notifikasi/get_notif.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData.containsKey('error')) {
          _errorMessage = jsonData['error'];
        } else {
          _notifications = (jsonData['notifications'] as List)
              .map((notif) => NotificationModel.fromJson(notif))
              .toList();
          _errorMessage = null;
        }
      } else {
        _errorMessage =
            "Failed to load data: Status code ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addWelcomeNotificationIfNeeded() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/notifikasi/get_notif.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final notifications = (jsonData['notifications'] as List)
            .map((notif) => NotificationModel.fromJson(notif))
            .toList();
        bool welcomeNotificationExists = notifications
            .any((notif) => notif.name == "Selamat Datang di eMasjid.id");
        if (!welcomeNotificationExists) {
          final addResponse = await http.post(
            Uri.parse('http://emasjid.id/api/notifikasi/post_notif.php'),
            headers: {
              'Content-Type': 'application/json',
              'Cookie': 'PHPSESSID=$sessionId',
            },
          );

          if (addResponse.statusCode == 200) {
            var jsonResponse = json.decode(addResponse.body);
            if (jsonResponse['status'] == 'success') {
              await fetchNotifications();
            } else {
              _errorMessage = jsonResponse['message'];
            }
          } else {
            throw Exception(
                'Failed to add notification: Status code ${addResponse.statusCode}');
          }
        }
      } else {
        _errorMessage =
            "Failed to load data: Status code ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = 'Error while adding welcome notification: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateNotificationStatus(int no, String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      if (sessionId == null) {
        _errorMessage = 'Session ID not found';
        _isLoading = false;
        notifyListeners();
        return;
      }
      final response = await http.post(
        Uri.parse('http://emasjid.id/api/notifikasi/update_status_notif.php'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: json.encode({
          'no': no,
          'status': status,
        }),
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'success') {
          await fetchNotifications();
        } else {
          _errorMessage =
              jsonResponse['message'] ?? 'Failed to update notification status';
        }
      } else {
        _errorMessage =
            'Failed to update notification status: Status code ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to update notification status: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:e_mosque/controllers/notification_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/components/loader.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/pages/auth/auth.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:e_mosque/model/user_model.dart';

class AuthController {
  final String baseUrl = "http://emasjid.id/api/auth/";
  final String resetUrl = 'https://emasjid.id/app/module/account/';

  Future<User?> login(
      String username, String password, BuildContext context) async {
    final url = Uri.parse(baseUrl + 'login.php');
    final body = {
      'username': username,
      'password': password,
    };

    print("Sending login request to: $url with body: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final result = json.decode(response.body);

        if (result['status'] == 'success') {
          User user = User(
            userId: result['user_id'],
            username: result['username'] ?? '',
            name: result['name'] ?? '',
            category: result['category'] ?? 'member',
            replika: result['replika'] ?? '',
            referral: result['referral'] ?? '',
            subdomain: result['subdomain'] ?? '',
            link: result['link'] ?? '',
            numberId: result['number_id'] ?? '',
            birth: result['birth'] ?? '',
            sex: result['sex'] ?? 'L',
            address: result['address'] ?? '',
            city: result['city'] ?? '',
            phone: result['phone'] ?? '',
            email: result['email'] ?? '',
            bankName: result['bank_name'] ?? '',
            bankBranch: result['bank_branch'] ?? '',
            bankAccountNumber: result['bank_account_number'] ?? '',
            bankAccountName: result['bank_account_name'] ?? '',
            lastLogin: result['last_login'] ?? '',
            lastIpAddress: result['last_ipaddress'] ?? '',
            picture: result['picture'] ?? '',
            date: result['date'] ?? '',
            publish: result['publish'] ?? '1',
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', result['username']);
          if (response.headers.containsKey('set-cookie')) {
            String? sessionId =
                response.headers['set-cookie']?.split(';')[0].split('=')[1];
            if (sessionId != null) {
              await prefs.setString('session_id', sessionId);

              // Memanggil NotificationProvider dan menambahkan notifikasi sambutan
              final notificationProvider =
                  Provider.of<NotificationProvider>(context, listen: false);
              try {
                await notificationProvider.addWelcomeNotificationIfNeeded();
              } catch (e) {
                // Tampilkan pesan error jika gagal menambahkan notifikasi
                print("Error adding welcome notification: $e");
                GlobalAlert.showAlert(
                  context: context,
                  title: "Notifikasi Gagal",
                  message: "Gagal membuat notifikasi sambutan.",
                  type: AlertType.error,
                );
              }
            }
          }

          Provider.of<UserProvider>(context, listen: false).setUser(user);
          GlobalAlert.showAlert(
            context: context,
            title: "Login Berhasil",
            message: "Selamat datang, ${user.name}!",
            type: AlertType.success,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          );
          return user;
        } else {
          GlobalAlert.showAlert(
            context: context,
            title: "Login Gagal",
            message: result['message'],
            type: AlertType.error,
          );
          return null;
        }
      } else {
        print("Login failed with status code: ${response.statusCode}");
        GlobalAlert.showAlert(
          context: context,
          title: "Login Gagal",
          message: "Gagal terhubung ke server.",
          type: AlertType.error,
        );
        return null;
      }
    } catch (e) {
      print("Error during login: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
      return null;
    }
  }

  Future<User?> register(
    String username,
    String name,
    String phone,
    String email,
    String password,
    BuildContext context,
  ) async {
    final url = Uri.parse(baseUrl + 'register.php');
    final body = {
      'username': username,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };

    print("Sending register request to: $url with body: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          User user = User(
            userId: result['user_id'],
            username: result['username'] ?? '',
            name: result['name'] ?? '',
            category: result['category'] ?? 'member',
            replika: result['replika'] ?? '',
            referral: result['referral'] ?? '',
            subdomain: result['subdomain'] ?? '',
            link: result['link'] ?? '',
            numberId: result['number_id'] ?? '',
            birth: result['birth'] ?? '',
            sex: result['sex'] ?? 'L',
            address: result['address'] ?? '',
            city: result['city'] ?? '',
            phone: result['phone'] ?? '',
            email: result['email'] ?? '',
            bankName: result['bank_name'] ?? '',
            bankBranch: result['bank_branch'] ?? '',
            bankAccountNumber: result['bank_account_number'] ?? '',
            bankAccountName: result['bank_account_name'] ?? '',
            lastLogin: result['last_login'] ?? '',
            lastIpAddress: result['last_ipaddress'] ?? '',
            picture: result['picture'] ?? '',
            date: result['date'] ?? '',
            publish: result['publish'] ?? '1',
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', result['username']);

          if (response.headers.containsKey('set-cookie')) {
            String? sessionId =
                response.headers['set-cookie']?.split(';')[0].split('=')[1];
            if (sessionId != null) {
              await prefs.setString('session_id', sessionId);

              // Memanggil NotificationProvider dan menambahkan notifikasi sambutan
              final notificationProvider =
                  Provider.of<NotificationProvider>(context, listen: false);
              try {
                await notificationProvider.addWelcomeNotificationIfNeeded();
              } catch (e) {
                // Tampilkan pesan error jika gagal menambahkan notifikasi
                print("Error adding welcome notification: $e");
                GlobalAlert.showAlert(
                  context: context,
                  title: "Notifikasi Gagal",
                  message: "Gagal membuat notifikasi sambutan.",
                  type: AlertType.error,
                );
              }
            }
          }

          Provider.of<UserProvider>(context, listen: false).setUser(user);
          GlobalAlert.showAlert(
            context: context,
            title: "Registrasi Berhasil",
            message: "Selamat datang, ${user.name}!",
            type: AlertType.success,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          );
          return user;
        } else {
          String errorMessage =
              result['message'] ?? 'Gagal melakukan registrasi.';
          GlobalAlert.showAlert(
            context: context,
            title: "Registrasi Gagal",
            message: errorMessage,
            type: AlertType.error,
          );
          return null;
        }
      } else {
        print("Register failed with status code: ${response.statusCode}");
        GlobalAlert.showAlert(
          context: context,
          title: "Registrasi Gagal",
          message: "Gagal terhubung ke server.",
          type: AlertType.error,
        );
        return null;
      }
    } catch (e) {
      print("Error during registration: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
      return null;
    }
  }

  // Fungsi untuk logout
  void logout(BuildContext context) {
    GlobalAlert.showConfirmation(
      context: context,
      title: "Konfirmasi Logout",
      message: "Apakah Anda yakin ingin logout?",
      confirmButtonText: "OK",
      cancelButtonText: "Cancel",
      onConfirm: () async {
        GlobalLoader.showLoadingDialog(context);
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('username');
          print("Username dihapus dari SharedPreferences");

          Provider.of<UserProvider>(context, listen: false).logout();
          await Future.delayed(const Duration(seconds: 1));
          GlobalLoader.hideLoadingDialog(context);
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthScreen()),
          );
        } catch (e) {
          GlobalLoader.hideLoadingDialog(context);
          print("Error during logout: $e");
          GlobalAlert.showAlert(
            context: context,
            title: "Logout Gagal",
            message: "Terjadi kesalahan saat logout. Coba lagi nanti.",
            type: AlertType.error,
          );
        }
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<bool> verifyUsername(String username, BuildContext context) async {
    final url = Uri.parse(baseUrl + 'verify_username.php');
    final body = {
      'username': username,
    };

    print("Sending verify username request to: $url with body: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          GlobalAlert.showAlert(
            context: context,
            title: "Username Valid",
            message:
                "Username valid. Anda akan diarahkan ke halaman reset password dalam 2 detik.",
            type: AlertType.success,
          );
          await Future.delayed(Duration(seconds: 2));
          return true;
        } else {
          GlobalAlert.showAlert(
            context: context,
            title: "Gagal",
            message: result['message'] ?? 'Terjadi kesalahan.',
            type: AlertType.error,
          );
          return false;
        }
      } else {
        print("Verification failed with status code: ${response.statusCode}");
        GlobalAlert.showAlert(
          context: context,
          title: "Gagal",
          message: "Gagal terhubung ke server.",
          type: AlertType.error,
        );
        return false;
      }
    } catch (e) {
      print("Error during username verification: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
      return false;
    }
  }

  Future<void> updatePassword(
  String oldPassword, 
  String newPassword, 
  BuildContext context,
) async {
  // Ambil username dari sesi pengguna, misalnya dari `Provider`
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  String username = userProvider.user?.username ?? "";

  final url = Uri.parse(baseUrl + 'update_password.php');

  final body = {
    'username': username,
    'password_lama': oldPassword,
    'password_baru': newPassword,
  };

    print("Sending update password request to: $url with body: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final result = json.decode(response.body);

        if (result['status'] == 'success') {
          GlobalAlert.showAlert(
            context: context,
            title: "Berhasil",
            message: "Password berhasil diubah.",
            type: AlertType.success,
          );

          // Menunggu 2 detik sebelum mengarahkan ke layar login
          await Future.delayed(Duration(seconds: 2));

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthScreen()),
          );
        } else {
          GlobalAlert.showAlert(
            context: context,
            title: "Gagal",
            message: result['message'] ??
                'Terjadi kesalahan saat mengganti password.',
            type: AlertType.error,
          );
        }
      } else {
        print(
            "Update password failed with status code: ${response.statusCode}");
        GlobalAlert.showAlert(
          context: context,
          title: "Gagal",
          message: "Gagal terhubung ke server.",
          type: AlertType.error,
        );
      }
    } catch (e) {
      print("Error during update password: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    final url = Uri.parse(
        baseUrl + 'reset_password.php'); // Path relatif ke endpoint PHP Anda
    final body = {
      'email': email,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final result = json.decode(response.body);

        if (result['status'] == 'success') {
          GlobalAlert.showAlert(
            context: context,
            title: "Berhasil",
            message: "Email reset password telah dikirim.",
            type: AlertType.success,
          );
        } else {
          GlobalAlert.showAlert(
            context: context,
            title: "Gagal",
            message: result['message'] ?? "Terjadi kesalahan.",
            type: AlertType.error,
          );
        }
      } else {
        GlobalAlert.showAlert(
          context: context,
          title: "Gagal",
          message: "Gagal terhubung ke server.",
          type: AlertType.error,
        );
      }
    } catch (e) {
      print("Error during reset password: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
    }
  }

  Future<void> triggerAddNotif() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('session_id');

    // Pastikan sessionId tidak null
    if (sessionId != null) {
      try {
        final response = await http.post(
          Uri.parse('http://emasjid.id/api/notifikasi/add_notif.php'),
          headers: {
            'Content-Type': 'application/json',
            'Cookie': 'PHPSESSID=$sessionId', // Kirim session ID sebagai cookie
          },
        );

        // Cek status response
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['status'] == 'success') {
            print('Notifikasi sambutan berhasil ditambahkan');
          } else {
            print('Error: ${jsonResponse['message']}');
          }
        } else {
          print('Failed to trigger addNotif: ${response.statusCode}');
        }
      } catch (e) {
        print('Error during addNotif request: $e');
      }
    } else {
      print('Session ID not found');
    }
  }
}

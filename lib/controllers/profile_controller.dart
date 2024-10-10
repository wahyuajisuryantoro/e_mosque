import 'dart:convert';
import 'dart:io';
import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileController {
  final String apiUrl = 'http://emasjid.id/api/profile/update_profile.php';

  
  Future<bool> updateProfile({
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String birth,
    required String sex,
    File? picture,
    required BuildContext context,
  }) async {
    try {
      if (name.isEmpty || email.isEmpty || phone.isEmpty || address.isEmpty || city.isEmpty || birth.isEmpty || sex.isEmpty) {
        GlobalAlert.showAlert(
          context: context,
          title: "Kesalahan",
          message: "Semua kolom wajib diisi.",
          type: AlertType.error,
        );
        return false;
      }
      if (!_validateEmail(email)) {
        GlobalAlert.showAlert(
          context: context,
          title: "Kesalahan",
          message: "Format email tidak valid.",
          type: AlertType.error,
        );
        return false;
      }
      if (!_validatePhone(phone)) {
        GlobalAlert.showAlert(
          context: context,
          title: "Kesalahan",
          message: "Nomor telepon tidak valid.",
          type: AlertType.error,
        );
        return false;
      }

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['user_id'] = userId;
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['address'] = address;
      request.fields['city'] = city;
      request.fields['birth'] = birth;
      request.fields['sex'] = sex;
      if (picture != null) {
        var pictureStream = http.ByteStream(picture.openRead());
        var pictureLength = await picture.length();
        var multipartFile = http.MultipartFile(
          'picture',
          pictureStream,
          pictureLength,
          filename: picture.path.split('/').last,
        );
        request.files.add(multipartFile);
        print("Gambar terlampir: ${picture.path}");
      }
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      final Map<String, dynamic> responseData = jsonDecode(responseBody.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        GlobalAlert.showAlert(
          context: context,
          title: "Berhasil",
          message: "Profil berhasil diperbarui.",
          type: AlertType.success,
        );
        return true;
      } else {
        GlobalAlert.showAlert(
          context: context,
          title: "Gagal",
          message: responseData['message'] ?? "Terjadi kesalahan saat memperbarui profil.",
          type: AlertType.error,
        );
        print("Update gagal: ${responseData['message']}");
        return false;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Kesalahan",
        message: "Terjadi kesalahan saat menghubungi server.",
        type: AlertType.error,
      );
      return false;
    }
  }

  bool _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    final phoneRegExp = RegExp(r'^[0-9]{10,}$');
    return phoneRegExp.hasMatch(phone);
  }

  
  Future<bool> updatePhotoProfile({
    required String userId,
    File? picture, 
    required BuildContext context,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['user_id'] = userId;

      if (picture != null) {
        var pictureStream = http.ByteStream(picture.openRead());
        var pictureLength = await picture.length();
        var multipartFile = http.MultipartFile(
          'picture',
          pictureStream,
          pictureLength,
          filename: picture.path.split('/').last,
        );
        request.files.add(multipartFile);
        print("Gambar terlampir: ${picture.path}");
      }

      
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      final Map<String, dynamic> responseData = jsonDecode(responseBody.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(
          userProvider.user!.copyWith(picture: responseData['picture']),
        );

        return true;
      } else {
        print("Update gambar gagal: ${responseData['message']}");
        return false;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      GlobalAlert.showAlert(
        context: context,
        title: "Error",
        message: "Gagal memperbarui gambar profil.",
        type: AlertType.error,
      );
      return false;
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:e_mosque/model/takmir.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakmirProvider with ChangeNotifier {
  List<Takmir> _takmirList = [];
  List<Map<String, dynamic>> _jabatanList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Takmir> get takmirList => _takmirList;
  List<Map<String, dynamic>> get jabatanList => _jabatanList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TakmirProvider() {
    fetchTakmir();
    fetchJabatan();
  }

  Future<void> fetchTakmir() async {
    _isLoading = true;
    notifyListeners();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      if (sessionId == null) {
        _errorMessage = "Session ID tidak tersedia. Silakan login.";
        _isLoading = false;
        notifyListeners();
        return;
      }
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/takmir/get_data_takmir.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          _takmirList = (jsonData['data'] as List)
              .map((item) => Takmir.fromJson(item))
              .toList();

          _errorMessage = null;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage = "Gagal memuat data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchJabatan() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      if (sessionId == null) {
        _errorMessage = "Session ID tidak tersedia. Silakan login.";
        _isLoading = false;
        notifyListeners();
        return;
      }
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/takmir/get_data_jabatan_takmir.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          _jabatanList = (jsonData['data'] as List)
              .map((item) => {
                    'no': int.parse(item['no'].toString()),
                    'name': item['name'],
                  })
              .toList();

          _errorMessage = null;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage =
            "Gagal memuat data jabatan: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> postDataTakmir({
    required String name,
    required String phone,
    String? email,
    required String address,
    String? link,
    required int noTakmirJabatan,
    File? picture,
  }) async {
    if (name.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        noTakmirJabatan == 0) {
      _errorMessage = "Semua kolom wajib diisi, dan jabatan harus dipilih.";
      notifyListeners();
      return false;
    }

    if (email != null && email.isNotEmpty && !_validateEmail(email)) {
      _errorMessage = "Format email tidak valid.";
      notifyListeners();
      return false;
    }

    if (!_validatePhone(phone)) {
      _errorMessage = "Nomor telepon tidak valid.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      if (sessionId == null) {
        _errorMessage = "Session ID tidak tersedia. Silakan login.";
        _isLoading = false;
        notifyListeners();
        return false;
      }

      var uri = Uri.parse('http://emasjid.id/api/takmir/post_data_takmir.php');
      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['phone'] = phone;
      if (email != null) request.fields['email'] = email;
      request.fields['address'] = address;
      if (link != null) request.fields['link'] = link;
      request.fields['no_takmir_jabatan'] = noTakmirJabatan.toString();

      if (picture != null) {
        String fileName = basename(picture.path);
        print("Mengirim gambar dengan nama file: $fileName");
        request.files.add(
          http.MultipartFile(
            'picture',
            picture.readAsBytes().asStream(),
            await picture.length(),
            filename: fileName,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      } else {
        print("Tidak ada gambar yang dikirim");
      }
      request.headers['Cookie'] = 'PHPSESSID=$sessionId';
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        if (jsonData['status'] == 'success') {
          await fetchTakmir();
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = jsonData['message'] ?? "Terjadi kesalahan.";
        }
      } else {
        _errorMessage =
            "Gagal mengirim data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan saat menghubungi server.";
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateDataTakmir({
    required int no,
    required String name,
    required String phone,
    required String address,
    String? email,
    required int noTakmirJabatan,
    File? picture,
    bool removePicture = false,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      if (sessionId == null) {
        _errorMessage = "Session ID tidak tersedia. Silakan login.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
      var uri =
          Uri.parse('http://emasjid.id/api/takmir/update_data_takmir.php');
      var request = http.MultipartRequest('POST', uri);

      // Tambahkan field wajib
      request.fields['no'] = no.toString();
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['address'] = address;
      request.fields['no_takmir_jabatan'] = noTakmirJabatan.toString();
      if (email != null) {
        request.fields['email'] = email;
      }

      if (removePicture) {
        request.fields['picture'] = '';
      } else if (picture != null) {
        String fileName = basename(picture.path);
        request.files.add(
          http.MultipartFile(
            'picture',
            picture.readAsBytes().asStream(),
            await picture.length(),
            filename: fileName,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      request.headers['Cookie'] = 'PHPSESSID=$sessionId';
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        if (jsonData['status'] == 'success') {
          await fetchTakmir();
          return true;
        } else {
          _errorMessage = jsonData['message'] ?? "Terjadi kesalahan.";
        }
      } else {
        _errorMessage =
            "Gagal mengirim data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan saat menghubungi server: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> deleteDataTakmir({
    required int no,
    required String username,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');
      if (sessionId == null) {
        _errorMessage = "Session ID tidak tersedia. Silakan login.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final url =
          Uri.parse('http://emasjid.id/api/takmir/delete_data_takmir.php');
      final response = await http.post(
        url,
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: {
          'no': no.toString(),
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          await fetchTakmir();
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = jsonData['message'] ?? "Terjadi kesalahan.";
        }
      } else {
        _errorMessage =
            "Gagal menghapus data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Terjadi kesalahan saat menghubungi server: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  bool _validateEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    final phoneRegExp = RegExp(r'^[0-9]{10,}$');
    return phoneRegExp.hasMatch(phone);
  }
}

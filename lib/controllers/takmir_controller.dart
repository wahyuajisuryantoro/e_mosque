import 'dart:convert';
import 'dart:io';
import 'package:e_mosque/components/alert.dart';
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
  }

  Future<void> fetchTakmir() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get session ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');
      print('Session ID: $sessionId');

      // Check if session ID exists
      if (sessionId == null) {
        _errorMessage = "Session ID is not available. Please log in.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Fetch data from the API
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/takmir/get_data_takmir.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          // Parsing takmir data
          _takmirList = (jsonData['data'] as List)
              .map((item) => Takmir.fromJson(item))
              .toList();
          _errorMessage = null;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage =
            "Failed to load data: Status code ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      print('Error in fetchTakmir: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getDataJabatanTakmir() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');
      if (sessionId == null) {
        _errorMessage = "Session ID is not available. Please log in.";
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
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
          _errorMessage = null;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage =
            "Failed to load jabatan data: Status code ${response.statusCode}";
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
  required String email,
  required String address,
  required String link,
  required int noTakmirJabatan,
  File? picture,
}) async {
  if (name.isEmpty ||
      phone.isEmpty ||
      address.isEmpty ||
      noTakmirJabatan == 0) {
    _errorMessage = "Semua kolom wajib diisi, dan jabatan harus dipilih.";
    _isLoading = false;
    notifyListeners();
    return false;
  }

  _isLoading = true;
  notifyListeners();

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('session_id');
    if (sessionId == null) {
      _errorMessage = "Session ID is not available. Please log in.";
      _isLoading = false;
      notifyListeners();
      return false;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://emasjid.id/api/takmir/post_data_takmir.php'),
    );

    // Tambahkan data form
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    request.fields['address'] = address;
    request.fields['link'] = link;
    request.fields['no_takmir_jabatan'] = noTakmirJabatan.toString();

    // Tambahkan gambar jika ada
    if (picture != null) {
      String mimeType = lookupMimeType(picture.path) ?? 'image/jpeg';
      var fileStream = http.ByteStream(picture.openRead());
      var fileLength = await picture.length();

      request.files.add(http.MultipartFile(
        'picture',
        fileStream,
        fileLength,
        filename: basename(picture.path),
        contentType:
            MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
      ));
    }

    request.headers['Cookie'] = 'PHPSESSID=$sessionId';

    // Kirim request ke server
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonData = json.decode(responseBody);

      if (jsonData['status'] == 'success') {
        await fetchTakmir(); // Memperbarui daftar takmir setelah berhasil
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = jsonData['message'] ?? "Terjadi kesalahan.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } else {
      _errorMessage =
          "Gagal mengirim data: Status code ${response.statusCode}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  } catch (e) {
    _errorMessage = "Terjadi kesalahan saat menghubungi server.";
    print("Error: $e");
    _isLoading = false;
    notifyListeners();
    return false;
  }
}


  // Validasi format email
  bool _validateEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  // Validasi nomor telepon
  bool _validatePhone(String phone) {
    final phoneRegExp = RegExp(r'^[0-9]{10,}$');
    return phoneRegExp.hasMatch(phone);
  }
}

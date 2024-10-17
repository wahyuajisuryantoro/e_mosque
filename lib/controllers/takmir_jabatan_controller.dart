import 'dart:convert';
import 'package:e_mosque/model/takmir_jabatan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TakmirJabatanProvider with ChangeNotifier {
  List<TakmirJabatan> _jabatanList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TakmirJabatan> get jabatanList => _jabatanList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TakmirJabatanProvider() {
    fetchJabatanTakmir();
  }

  Future<void> fetchJabatanTakmir() async {
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
              .map((item) => TakmirJabatan.fromJson(item))
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

  Future<bool> postDataJabatanTakmir({
    required String name,
    required int level,
    String? description,
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

      var uri = Uri.parse(
          'http://emasjid.id/api/takmir/post_data_jabatan_takmir.php');
      var request = http.MultipartRequest('POST', uri);
      request.fields['name'] = name;
      request.fields['subdomain'] = '';
      request.fields['level'] = level.toString();
      if (description != null) {
        request.fields['description'] = description;
      }
      request.headers['Cookie'] = 'PHPSESSID=$sessionId';
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        if (jsonData['status'] == 'success') {
          await fetchJabatanTakmir();
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

  Future<bool> updateJabatanTakmir({
    required int no,
    required String name,
    required String subdomain,
    required int level,
    String? description,
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

      var uri = Uri.parse(
          'http://emasjid.id/api/takmir/update_data_jabatan_takmir.php');
      var request = http.MultipartRequest('POST', uri);
      request.fields['no'] = no.toString();
      request.fields['name'] = name;
      request.fields['subdomain'] = subdomain;
      request.fields['level'] = level.toString();
      if (description != null) {
        request.fields['description'] = description;
      }

      request.headers['Cookie'] = 'PHPSESSID=$sessionId';
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        if (jsonData['status'] == 'success') {
          await fetchJabatanTakmir();
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

  Future<bool> deleteJabatanTakmir({required int no}) async {
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

      final uri = Uri.parse('http://emasjid.id/api/takmir/delete_data_jabatan_takmir.php');
      final request = http.MultipartRequest('POST', uri);
      request.fields['no'] = no.toString();
      request.headers['Cookie'] = 'PHPSESSID=$sessionId';

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);

        if (jsonData['status'] == 'success') {
          await fetchJabatanTakmir();
          return true;
        } else {
          _errorMessage = jsonData['message'] ?? 'Terjadi kesalahan saat menghapus.';
        }
      } else {
        _errorMessage = "Gagal menghapus data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}

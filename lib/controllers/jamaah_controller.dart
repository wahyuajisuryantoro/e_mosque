import 'dart:convert';
import 'dart:io';
import 'package:e_mosque/model/jamaah.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JamaahProvider with ChangeNotifier {
  List<Jamaah> _jamaahList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Jamaah> get jamaahList => _jamaahList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  JamaahProvider() {
    fetchJamaah();
  }

  Future<void> fetchJamaah() async {
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
        Uri.parse('http://emasjid.id/api/jamaah/get_data_jamaah.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          _jamaahList = (jsonData['data'] as List)
              .map((item) => Jamaah.fromJson(item))
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

  Future<bool> postDataJamaah({
    required String name,
    String nik = '-',
    String birthPlace = '-',
    String birthDate = '1970-01-01',
    String sex = 'L',
    String blood = 'A',
    String marital = 'menikah',
    String job = '-',
    String economicStatus = 'mampu',
    String donatur = '0',
    String jamaahStatus = 'jamaah',
    String address = '-',
    String village = '-',
    String subdistrict = '-',
    String city = '-',
    String province = '-',
    required String phone,
    String email = '-',
    String subdomain = '',
    File? picture,
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

      var uri = Uri.parse('http://emasjid.id/api/jamaah/post_data_jamaah.php');
      var request = http.MultipartRequest('POST', uri);
      request.headers['Cookie'] = 'PHPSESSID=$sessionId';

      request.fields['name'] = name;
      request.fields['nik'] = nik;
      request.fields['birth_place'] = birthPlace;
      request.fields['birth_date'] = birthDate;
      request.fields['sex'] = sex;
      request.fields['blood'] = blood;
      request.fields['marital'] = marital;
      request.fields['job'] = job;
      request.fields['economic_status'] = economicStatus;
      request.fields['donatur'] = donatur;
      request.fields['jamaah_status'] = jamaahStatus;
      request.fields['address'] = address;
      request.fields['village'] = village;
      request.fields['subdistrict'] = subdistrict;
      request.fields['city'] = city;
      request.fields['province'] = province;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['subdomain'] = subdomain;
      request.fields['link'] = '-';

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
      } else {
        request.fields['picture'] = '-';
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final jsonData = json.decode(responseBody.body);

        if (jsonData['status'] == 'success') {
          await fetchJamaah(); 
          _errorMessage = null;
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage = "Gagal mengirim data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateDataJamaah({
    required int no,
    required String name,
    required String phone,
    String? nik,
    String? birthPlace,
    String? birthDate,
    String? sex,
    String? blood,
    String? marital,
    String? job,
    String? economicStatus,
    String? donatur,
    String? jamaahStatus,
    String? address,
    String? village,
    String? subdistrict,
    String? city,
    String? province,
    String? email,
    String? subdomain,
    File? picture,
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

      var uri = Uri.parse('http://emasjid.id/api/jamaah/update_data_jamaah.php');
      var request = http.MultipartRequest('POST', uri);
      request.headers['Cookie'] = 'PHPSESSID=$sessionId';
      request.fields['no'] = no.toString();
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      if (nik != null && nik.isNotEmpty) request.fields['nik'] = nik;
      if (birthPlace != null && birthPlace.isNotEmpty) request.fields['birth_place'] = birthPlace;
      if (birthDate != null && birthDate.isNotEmpty) request.fields['birth_date'] = birthDate;
      if (sex != null && sex.isNotEmpty) request.fields['sex'] = sex;
      if (blood != null && blood.isNotEmpty) request.fields['blood'] = blood;
      if (marital != null && marital.isNotEmpty) request.fields['marital'] = marital;
      if (job != null && job.isNotEmpty) request.fields['job'] = job;
      if (economicStatus != null && economicStatus.isNotEmpty) request.fields['economic_status'] = economicStatus;
      if (donatur != null && donatur.isNotEmpty) request.fields['donatur'] = donatur;
      if (jamaahStatus != null && jamaahStatus.isNotEmpty) request.fields['jamaah_status'] = jamaahStatus;
      if (address != null && address.isNotEmpty) request.fields['address'] = address;
      if (village != null && village.isNotEmpty) request.fields['village'] = village;
      if (subdistrict != null && subdistrict.isNotEmpty) request.fields['subdistrict'] = subdistrict;
      if (city != null && city.isNotEmpty) request.fields['city'] = city;
      if (province != null && province.isNotEmpty) request.fields['province'] = province;
      if (email != null && email.isNotEmpty) request.fields['email'] = email;
      if (subdomain != null && subdomain.isNotEmpty) request.fields['subdomain'] = subdomain;
      request.fields['link'] = '-';

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
      }
      
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final jsonData = json.decode(responseBody.body);

        if (jsonData['status'] == 'success') {
          await fetchJamaah();
          _errorMessage = null;
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = jsonData['message'];
        }
      } else {
        _errorMessage = "Gagal mengirim data: Kode status ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> deleteDataJamaah({
    required int no,
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

      var uri = Uri.parse('http://emasjid.id/api/jamaah/delete_data_jamaah.php');
      var response = await http.post(
        uri,
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: {
          'no': no.toString(),
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          await fetchJamaah();  // Refresh data after deletion
          _errorMessage = null;
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = jsonData['message'];
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

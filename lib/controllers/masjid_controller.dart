import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_mosque/model/masjid.dart';

class MasjidProvider with ChangeNotifier {
  Masjid? _masjid;
  bool _isLoading = false;
  String? _errorMessage;

  Masjid? get masjid => _masjid;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get masjidName => _masjid?.name;

  MasjidProvider() {
    fetchMasjid();
  }

  Future<void> fetchMasjid() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      final response = await http.get(
        Uri.parse('http://emasjid.id/api/masjid/get_data_masjid.php'),
        headers: {
          'Cookie': 'PHPSESSID=$sessionId',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData.containsKey('error')) {
          _errorMessage = jsonData['error'];
        } else {
          _masjid = Masjid.fromJson(jsonData);
          if (_masjid!.picture!.isNotEmpty) {
            _masjid!.picture =
                'https://www.emasjid.id/amm/upload/picture/${_masjid!.picture}';
          }

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

  Future<void> updateDataMasjid(
    String name,
    String luasTanah,
    String luasBangunan,
    String statusTanah,
    String tahunBerdiri,
    String legalitas,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      final response = await http.post(
        Uri.parse('http://emasjid.id/api/masjid/update_informasi_masjid.php'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: json.encode({
          'page': 'data_masjid',
          'name': name,
          'luasTanah': luasTanah,
          'luasBangunan': luasBangunan,
          'statusTanah': statusTanah,
          'tahunBerdiri': tahunBerdiri,
          'legalitas': legalitas,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['message'] == "Record updated successfully") {
            print("Data masjid updated successfully");
          } else {
            print("Error: ${jsonResponse['error']}");
            _errorMessage = jsonResponse['error'];
          }
        } else {
          print("Response body is empty");
          throw Exception('Empty response body');
        }
      } else {
        throw Exception(
            'Failed to update data: Status code ${response.statusCode}');
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      _errorMessage = 'Failed to update data: $e';
    }
    notifyListeners();
  }

  Future<void> updateTentangMasjid(String content) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      final response = await http.post(
        Uri.parse('http://emasjid.id/api/masjid/update_informasi_masjid.php'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: json.encode({
          'page': 'tentang',
          'content': content,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == "Record updated successfully") {
          print("Tentang masjid updated successfully");
        } else {
          print("Error: ${jsonResponse['error']}");
          _errorMessage = jsonResponse['error'];
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      _errorMessage = 'Failed to update data: $e';
    }
    notifyListeners();
  }

  Future<void> updateAlamatMasjid(
  String address,
  String city,
  String maps,
  String phone,
  String email,
) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('session_id');

    final response = await http.post(
      Uri.parse('http://emasjid.id/api/masjid/update_informasi_masjid.php'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'PHPSESSID=$sessionId',
      },
      body: json.encode({
        'page': 'alamat',
        'address': address,
        'city': city,
        'maps': maps,
        'phone': phone,
        'email': email,
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['message'] == "Record updated successfully") {
        print("Alamat masjid updated successfully");
        _errorMessage = null;
      } else {
        print("Error: ${jsonResponse['error']}");
        _errorMessage = jsonResponse['error'];
      }
    } else {
      _errorMessage =
          'Failed to update data: Status code ${response.statusCode}';
      print("Error: $_errorMessage");
    }
  } catch (e) {
    print("Error during HTTP request: $e");
    _errorMessage = 'Failed to update data: $e';
  }
  notifyListeners();
}


  Future<void> updateFotoMasjid(File imageFile) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('session_id');

    String fileName = basename(imageFile.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://emasjid.id/api/masjid/upload_foto_masjid.php'),
    );
    request.headers.addAll({
      'Cookie': 'PHPSESSID=$sessionId',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'picture',
        imageFile.path,
        filename: fileName,
        contentType: MediaType(
          'image',
          lookupMimeType(imageFile.path)!.split('/').last,
        ),
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print("Status Code: ${response.statusCode}");
    print("Response Body: $responseBody");

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseBody);

      if (jsonResponse['message'] == 'File uploaded successfully') {
        print("Foto masjid updated successfully");
        _errorMessage = null;
      } else {
        _errorMessage = jsonResponse['error'];
        print("Error: $_errorMessage");
      }
    } else {
      _errorMessage =
          'Failed to upload photo: Status code ${response.statusCode}';
      print("Error: $_errorMessage");
    }
  } catch (e) {
    _errorMessage = 'Failed to upload photo: $e';
    print("Error during HTTP request: $e");
  }

  notifyListeners();
}


  Future<void> updateSosialMediaMasjid(
    String facebook,
    String twitter,
    String instagram,
    String youtube,
    String tiktok,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('session_id');

      final response = await http.post(
        Uri.parse('http://emasjid.id/api/masjid/update_informasi_masjid.php'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'PHPSESSID=$sessionId',
        },
        body: json.encode({
          'page': 'sosial_media',
          'facebook': facebook,
          'twitter': twitter,
          'instagram': instagram,
          'youtube': youtube,
          'tiktok': tiktok,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == "Record updated successfully") {
          print("Sosial media masjid updated successfully");
        } else {
          print("Error: ${jsonResponse['error']}");
          _errorMessage = jsonResponse['error'];
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      _errorMessage = 'Failed to update data: $e';
    }
    notifyListeners();
  }
}

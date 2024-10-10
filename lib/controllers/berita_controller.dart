import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:e_mosque/model/berita.dart';

class BeritaProvider with ChangeNotifier {
  List<Berita> _beritaList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Berita> get beritaList => _beritaList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  BeritaProvider() {
    fetchBerita();
  }

 Future<void> fetchBerita() async {
  _isLoading = true;
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse('http://emasjid.id/api/berita/get_data_berita.php'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'success') {
        _beritaList = (jsonData['data'] as List)
            .map((item) => Berita.fromJson(item))
            .toList();
        _errorMessage = null;
      } else {
        _errorMessage = jsonData['message'];
      }
    } else {
      _errorMessage = "Failed to load data: Status code ${response.statusCode}";
    }
  } catch (e) {
    _errorMessage = "Error: $e";
   
  }
  _isLoading = false;
   notifyListeners();
 
}


  Future<void> postBerita({
    required String title,
    required String content,
    required String author,
    required File imageFile,
    String publish = '1',
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      String fileName = basename(imageFile.path);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://emasjid.id/api/berita/post_data_berita.php'),
      );
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['author'] = author;
      request.fields['publish'] = publish;
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: fileName,
          contentType: MediaType(
              'image', lookupMimeType(imageFile.path)!.split('/').last),
        ),
      );
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        if (jsonResponse['status'] == 'success') {
          print("Berita berhasil ditambahkan");
          _errorMessage = null;
          fetchBerita();
        } else {
          _errorMessage = jsonResponse['message'];
          print("Error: $_errorMessage");
        }
      } else {
        throw Exception(
            'Failed to post berita: Status code ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Failed to post berita: $e';
      print("Error during HTTP request: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

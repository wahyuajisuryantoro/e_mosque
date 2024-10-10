import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_mosque/model/acara.dart';

class AcaraProvider with ChangeNotifier {
  List<Acara> _acaraList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Acara> get acaraList => _acaraList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AcaraProvider() {
    fetchAcara();
  }

  Future<void> fetchAcara() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/acara/get_data_acara.php'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success') {
          _acaraList = (jsonData['data'] as List)
              .map((item) => Acara.fromJson(item))
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
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshAcara() async {
    _isLoading = true;
    notifyListeners();

    try {
      await fetchAcara();
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}

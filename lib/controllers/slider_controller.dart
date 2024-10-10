import 'dart:convert';
import 'package:e_mosque/model/slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SliderProvider with ChangeNotifier {
  List<SliderModel> _sliderList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<SliderModel> get sliderList => _sliderList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  SliderProvider() {
    fetchSlider();
  }

  Future<void> fetchSlider() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://emasjid.id/api/slider/get_slider.php'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          _sliderList = (jsonData['sliders'] as List)
              .map((item) => SliderModel.fromJson(item))
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
}

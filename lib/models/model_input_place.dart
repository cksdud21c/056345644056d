// model/model_input_place.dart
import 'package:flutter/material.dart';

class InputPlaceModel extends ChangeNotifier {
  String _place = "ㄴㄴ";
  String _district ="성동구";
  String _category ="관광지";

  String get place => _place;
  String get district => _district;
  String get category => _category;

  void setPlace(String p) {
    _place = p;
    notifyListeners();
  }

  void setSelectedDistrict(String d) {
    _district = d;
    notifyListeners();
  }
  void setSelectedCategory(String c) {
    _category = c;
    notifyListeners();
  }
}
// models/model_register.dart
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  String _id = "";
  String _pw = "";
  String _pwconfirm = "";
  String _gender="";
  String _age="";

  String get id => _id;
  String get pw => _pw;
  String get pwconfirm => _pwconfirm;
  String get gender => _gender;
  String get age => _age;

  void setId(String i) {
    _id = i;
    notifyListeners();
  }

  void setPw(String p) {
    _pw = p;
    notifyListeners();
  }

  void setPwConfirm(String pc) {
    _pwconfirm = pc;
    notifyListeners();
  }

  void setGender(String g) {
    _gender = g;
    notifyListeners();
  }

  void setAge(String a) {
    _age = a;
    notifyListeners();
  }
}
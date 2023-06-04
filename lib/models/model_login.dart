// model/model_login.dart
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier { //상태변경알리미
  String _email = ""; //상태를 저장하는 변수
  String _password = ""; //상태를 저장하는 변수

  String get email => _email;
  String get password => _password;
  void setEmail(String e) {
    _email = e;
    notifyListeners();//변경이 이루어졌으므로, ChangeNotifierProvider에세 변경되었음을 알림
  }

  void setPassword(String p) {
    _password = p;
    notifyListeners();
  }
}
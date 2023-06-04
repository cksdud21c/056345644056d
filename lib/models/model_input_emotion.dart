// model/model_input_emotion.dart
import 'package:flutter/material.dart';

class InputEmotionModel extends ChangeNotifier {
  String emotion = "";
  String get Emotion => emotion;
  void setEmotion(String e) {
    emotion = e;
    notifyListeners();
  }
}
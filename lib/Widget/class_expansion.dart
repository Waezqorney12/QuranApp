import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
class ExpansionColor with ChangeNotifier{
  bool _isGrey = false;
  bool get isGrey => _isGrey;
  set isGrey(bool value)
  {
    _isGrey = value;
    notifyListeners();
  }
  Color get isColor => (_isGrey) ? Colors.blue : Colors.grey;
}
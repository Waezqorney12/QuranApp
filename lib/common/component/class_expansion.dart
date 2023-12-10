import 'package:flutter/material.dart';

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
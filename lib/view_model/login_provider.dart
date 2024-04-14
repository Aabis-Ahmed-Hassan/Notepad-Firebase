import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}

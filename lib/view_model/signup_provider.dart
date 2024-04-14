import 'package:flutter/foundation.dart';

class SignupProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}

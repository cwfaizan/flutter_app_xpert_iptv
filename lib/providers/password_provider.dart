import 'package:flutter/foundation.dart';

class PasswordProvider with ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure {
    return _isObscure;
  }

  void toggleIsObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}

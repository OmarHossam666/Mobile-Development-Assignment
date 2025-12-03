import 'package:flutter/foundation.dart';
import '../../../core/utils/validators.dart';

enum AuthStatus { initial, loading, success, error }

class LoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;
  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;

  String? _emailError;
  String? _passwordError;
  bool _hasAttemptedSubmit = false;

  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isLoading => _status == AuthStatus.loading;

  bool get isFormValid =>
      _emailError == null &&
      _passwordError == null &&
      _email.isNotEmpty &&
      _password.isNotEmpty;

  void setEmail(String value) {
    _email = Validators.sanitizeInput(value);
    if (_hasAttemptedSubmit) {
      _validateEmail();
    }
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    if (_hasAttemptedSubmit) {
      _validatePassword();
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void _validateEmail() {
    _emailError = Validators.validateEmail(_email);
  }

  void _validatePassword() {
    _passwordError = Validators.validatePassword(_password);
  }

  bool validateForm() {
    _hasAttemptedSubmit = true;
    _validateEmail();
    _validatePassword();
    notifyListeners();
    return _emailError == null && _passwordError == null;
  }

  Future<bool> login() async {
    if (!validateForm()) {
      return false;
    }

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      _status = AuthStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Login failed. Please check your credentials.';
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _email = '';
    _password = '';
    _isPasswordVisible = false;
    _status = AuthStatus.initial;
    _errorMessage = null;
    _emailError = null;
    _passwordError = null;
    _hasAttemptedSubmit = false;
    notifyListeners();
  }

  void clearSensitiveData() {
    _password = '';
  }
}

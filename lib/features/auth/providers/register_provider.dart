import 'package:flutter/foundation.dart';
import '../../../core/utils/validators.dart';

enum AuthStatus { initial, loading, success, error }

class RegisterProvider extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;
  bool _wantsOffers = false;
  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  bool _hasAttemptedSubmit = false;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get wantsOffers => _wantsOffers;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get firstNameError => _firstNameError;
  String? get lastNameError => _lastNameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isLoading => _status == AuthStatus.loading;

  bool get isFormValid =>
      _firstNameError == null &&
      _lastNameError == null &&
      _emailError == null &&
      _passwordError == null &&
      _firstName.isNotEmpty &&
      _lastName.isNotEmpty &&
      _email.isNotEmpty &&
      _password.isNotEmpty;

  void setFirstName(String value) {
    _firstName = Validators.sanitizeInput(value);
    if (_hasAttemptedSubmit) {
      _validateFirstName();
    }
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = Validators.sanitizeInput(value);
    if (_hasAttemptedSubmit) {
      _validateLastName();
    }
    notifyListeners();
  }

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

  void toggleWantsOffers() {
    _wantsOffers = !_wantsOffers;
    notifyListeners();
  }

  void setWantsOffers(bool value) {
    _wantsOffers = value;
    notifyListeners();
  }

  void _validateFirstName() {
    _firstNameError = Validators.validateName(
      _firstName,
      fieldName: 'First name',
    );
  }

  void _validateLastName() {
    _lastNameError = Validators.validateName(_lastName, fieldName: 'Last name');
  }

  void _validateEmail() {
    _emailError = Validators.validateEmail(_email);
  }

  void _validatePassword() {
    _passwordError = Validators.validateRegistrationPassword(_password);
  }

  bool validateForm() {
    _hasAttemptedSubmit = true;
    _validateFirstName();
    _validateLastName();
    _validateEmail();
    _validatePassword();
    notifyListeners();
    return _firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null;
  }

  Future<bool> register() async {
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
      _errorMessage = 'Registration failed. Please try again.';
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _firstName = '';
    _lastName = '';
    _email = '';
    _password = '';
    _isPasswordVisible = false;
    _wantsOffers = false;
    _status = AuthStatus.initial;
    _errorMessage = null;
    _firstNameError = null;
    _lastNameError = null;
    _emailError = null;
    _passwordError = null;
    _hasAttemptedSubmit = false;
    notifyListeners();
  }

  void clearSensitiveData() {
    _password = '';
  }
}

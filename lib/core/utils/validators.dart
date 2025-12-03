class Validators {
  Validators._();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$',
  );

  static const int minPasswordLength = 6;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final trimmedValue = value.trim();

    if (!_emailRegExp.hasMatch(trimmedValue)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }

    return null;
  }

  static String? validateRegistrationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.trim().isEmpty) {
      return 'Password cannot contain only spaces';
    }

    if (value.length < minPasswordLength) {
      return 'Your password must be at least $minPasswordLength characters';
    }

    return null;
  }

  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < minNameLength) {
      return '$fieldName must be at least $minNameLength characters';
    }

    if (trimmedValue.length > maxNameLength) {
      return '$fieldName must be less than $maxNameLength characters';
    }

    final nameRegExp = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegExp.hasMatch(trimmedValue)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  static String? validateRequired(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String sanitizeInput(String input) {
    return input.trim();
  }
}

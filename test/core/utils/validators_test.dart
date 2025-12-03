import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_development_assignment/core/utils/validators.dart';

/// Unit tests for the [Validators] class.
///
/// These tests verify the validation logic for:
/// - Email address format
/// - Password requirements
/// - Name field validation
/// - Required field validation
void main() {
  group('Validators.validateEmail', () {
    test('returns error for null email', () {
      expect(Validators.validateEmail(null), isNotNull);
      expect(Validators.validateEmail(null), equals('Email is required'));
    });

    test('returns error for empty email', () {
      expect(Validators.validateEmail(''), isNotNull);
      expect(Validators.validateEmail(''), equals('Email is required'));
    });

    test('returns error for whitespace-only email', () {
      expect(Validators.validateEmail('   '), isNotNull);
      expect(Validators.validateEmail('   '), equals('Email is required'));
    });

    test('returns error for invalid email format', () {
      final invalidEmails = [
        'invalid',
        'invalid@',
        '@example.com',
        'invalid.example.com',
        'invalid@.com',
      ];

      for (final email in invalidEmails) {
        expect(
          Validators.validateEmail(email),
          equals('Please enter a valid email address'),
          reason: 'Expected "$email" to be invalid',
        );
      }
    });

    test('returns null for valid email', () {
      final validEmails = [
        'test@example.com',
        'user.name@example.com',
        'user+tag@example.com',
        'user@subdomain.example.com',
        'USER@EXAMPLE.COM',
      ];

      for (final email in validEmails) {
        expect(
          Validators.validateEmail(email),
          isNull,
          reason: 'Expected "$email" to be valid',
        );
      }
    });

    test('trims whitespace from email', () {
      expect(Validators.validateEmail('  test@example.com  '), isNull);
    });
  });

  group('Validators.validatePassword', () {
    test('returns error for null password', () {
      expect(Validators.validatePassword(null), isNotNull);
      expect(Validators.validatePassword(null), equals('Password is required'));
    });

    test('returns error for empty password', () {
      expect(Validators.validatePassword(''), isNotNull);
      expect(Validators.validatePassword(''), equals('Password is required'));
    });

    test('returns error for password shorter than 6 characters', () {
      expect(
        Validators.validatePassword('12345'),
        equals('Password must be at least 6 characters'),
      );
      expect(
        Validators.validatePassword('abc'),
        equals('Password must be at least 6 characters'),
      );
    });

    test('returns null for password with exactly 6 characters', () {
      expect(Validators.validatePassword('123456'), isNull);
      expect(Validators.validatePassword('abcdef'), isNull);
    });

    test('returns null for password longer than 6 characters', () {
      expect(Validators.validatePassword('1234567'), isNull);
      expect(Validators.validatePassword('verysecurepassword'), isNull);
    });
  });

  group('Validators.validateRegistrationPassword', () {
    test('returns error for null password', () {
      expect(Validators.validateRegistrationPassword(null), isNotNull);
    });

    test('returns error for empty password', () {
      expect(Validators.validateRegistrationPassword(''), isNotNull);
    });

    test('returns error for whitespace-only password', () {
      expect(
        Validators.validateRegistrationPassword('      '),
        equals('Password cannot contain only spaces'),
      );
    });

    test('returns error for short password', () {
      expect(
        Validators.validateRegistrationPassword('12345'),
        equals('Your password must be at least 6 characters'),
      );
    });

    test('returns null for valid password', () {
      expect(Validators.validateRegistrationPassword('password123'), isNull);
    });
  });

  group('Validators.validateName', () {
    test('returns error for null name', () {
      expect(
        Validators.validateName(null, fieldName: 'First name'),
        equals('First name is required'),
      );
    });

    test('returns error for empty name', () {
      expect(
        Validators.validateName('', fieldName: 'Last name'),
        equals('Last name is required'),
      );
    });

    test('returns error for name shorter than 2 characters', () {
      expect(
        Validators.validateName('A', fieldName: 'First name'),
        equals('First name must be at least 2 characters'),
      );
    });

    test('returns error for name longer than 50 characters', () {
      final longName = 'A' * 51;
      expect(
        Validators.validateName(longName, fieldName: 'First name'),
        equals('First name must be less than 50 characters'),
      );
    });

    test('returns error for name with invalid characters', () {
      expect(
        Validators.validateName('John123', fieldName: 'First name'),
        contains('can only contain letters'),
      );
      expect(
        Validators.validateName('John@Doe', fieldName: 'First name'),
        contains('can only contain letters'),
      );
    });

    test('returns null for valid name', () {
      expect(Validators.validateName('John', fieldName: 'First name'), isNull);
      expect(
        Validators.validateName('Mary-Jane', fieldName: 'First name'),
        isNull,
      );
      expect(
        Validators.validateName("O'Brien", fieldName: 'Last name'),
        isNull,
      );
      expect(
        Validators.validateName('Mary Jane', fieldName: 'First name'),
        isNull,
      );
    });

    test('trims whitespace from name', () {
      expect(
        Validators.validateName('  John  ', fieldName: 'First name'),
        isNull,
      );
    });
  });

  group('Validators.validateRequired', () {
    test('returns error for null value', () {
      expect(
        Validators.validateRequired(null, fieldName: 'Field'),
        equals('Field is required'),
      );
    });

    test('returns error for empty value', () {
      expect(
        Validators.validateRequired('', fieldName: 'Field'),
        equals('Field is required'),
      );
    });

    test('returns error for whitespace-only value', () {
      expect(
        Validators.validateRequired('   ', fieldName: 'Field'),
        equals('Field is required'),
      );
    });

    test('returns null for non-empty value', () {
      expect(Validators.validateRequired('value', fieldName: 'Field'), isNull);
    });

    test('uses default field name', () {
      expect(
        Validators.validateRequired(null),
        equals('This field is required'),
      );
    });
  });

  group('Validators.sanitizeInput', () {
    test('trims whitespace from input', () {
      expect(Validators.sanitizeInput('  test  '), equals('test'));
      expect(Validators.sanitizeInput('test'), equals('test'));
    });

    test('handles empty string', () {
      expect(Validators.sanitizeInput(''), equals(''));
    });

    test('handles whitespace-only string', () {
      expect(Validators.sanitizeInput('   '), equals(''));
    });
  });
}

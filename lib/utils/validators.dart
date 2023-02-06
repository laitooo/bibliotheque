enum PasswordError { notMatching, invalid }

// for password and confirm password
class Password {
  static PasswordError? validateMatch(String password, String confirmPassword) {
    return password != confirmPassword ? PasswordError.notMatching : null;
  }

  static PasswordError? validate(String password) {
    return password.trim().isEmpty ? PasswordError.invalid : null;
  }
}

enum PhoneNumberError { invalid }

class PhoneNumber {
  static PhoneNumberError? validate(String phoneNumber) {
    return RegExp(r'^[+][0-9]+$').hasMatch(phoneNumber)
        ? null
        : PhoneNumberError.invalid;
  }
}

enum UsernameError { empty }

class Username {
  static UsernameError? validate(String username) {
    return username.isEmpty ? UsernameError.empty : null;
  }
}

enum EmailError { invalid }

class Email {
  static EmailError? validate(String email) {
    return email.contains('@') ? null : EmailError.invalid;
  }
}

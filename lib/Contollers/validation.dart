class Validator {
  static String? isValidEmail(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    bool isValidFormat = emailRegex.hasMatch(email);

    if (!isValidFormat) {
      return "Invalid email format";
    }

    if (!email.endsWith('@akgec.ac.in')) {
      return "Email must end with @akgec.ac.in";
    }

    return null; // Indicates the email is valid
  }

  static String? isResetPassword(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return "Cannot be empty";
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');
    bool isValidFormat = passwordRegex.hasMatch(password);

    if (password.length < 8) {
      return "Password must contain atleast 8 characters";
    }

    if (!isValidFormat) {
      return "Please Enter a Strong Password";
    }

    if(password != confirmPassword) {
      return "Password Mismatch";
    }

    return null; // Indicates the email is valid
  }

  static String? isValidPassword(String password) {
    if (password.isEmpty) {
      return "Password Cannot be empty";
    }

    return null; // Indicates the email is valid
  }


}

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
}

class Validate {
  static final RegExp letterRegExp = RegExp('[a-zA-Z]');

  bool isInvalidUserName(String value) {
    String pattern = r"^[A-Za-z][A-Za-z0-9_]{5,11}$";
    RegExp regExp = RegExp(pattern);
    final invalidUserName = !regExp.hasMatch(value);
    return invalidUserName;
  }

  bool isInvalidPassword(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}$';
    RegExp regExp = RegExp(pattern);
    bool invalidPassword = !regExp.hasMatch(value);
    return invalidPassword;
  }

  bool isInvalidNumber(String value) {
    RegExp regExp = RegExp(r'^[0-9]{10}$');
    return !regExp.hasMatch(value);
  }

  bool isInvalidName(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z]{1,30}$');
    return !regExp.hasMatch(value);
  }

  bool isInvalidEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }
}

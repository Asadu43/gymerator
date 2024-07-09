class ApiConstants {
  ApiConstants._();

  // static const String baseUrl = "https://simphoneserver.herokuapp.com";
  static const String baseUrl = "http://3.64.190.185:5100";
  static const String signUp = "$baseUrl/api/user/signup";
  static const String signIn = "$baseUrl/api/user/login";
  static const String forgetPassword = "$baseUrl/api/user/forgotPassword";
  static const String verifyOTP = "$baseUrl/api/user/verifyOTP";
  static const String updatePassword = "$baseUrl/api/user/verifyOTP";
}
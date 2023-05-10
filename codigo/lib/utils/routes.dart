class Routes {
  static const String authService =
      "https://identitytoolkit.googleapis.com/v1/";

  static const String apiKey = "AIzaSyC0mBHb5w49PpjYZm_wnPmEyLPj09IE7EA";

  String signIn() {
    return "${authService}accounts:signInWithPassword?key=$apiKey";
  }

  String signUp() {
    return "${authService}accounts:signUp?key=$apiKey";
  }
}

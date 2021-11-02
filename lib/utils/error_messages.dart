import 'package:movie_world/api/api_status.dart';

class ErrorMessages {
  static String getErrorMessage(ApiStatus response) {
    switch (response) {
      case ApiStatus.EMAIL_EXISTS:
        return "Email already exist";
      case ApiStatus.EMAIL_NOT_FOUND:
        return "Entered Email not found";
      case ApiStatus.INVALID_PASSWORD:
        return "Your password incorrect";
      default:
        return "Sorry, Something went wrong\n";
    }
  }
}

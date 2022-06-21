import '../../libs.dart';

class UserRegisterResponse {
  User? user;
  int statusCode;
  String msg;

  UserRegisterResponse({
    this.user,
    required this.statusCode,
    required this.msg,
  });
}

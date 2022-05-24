import "../../libs.dart";

class UsersLoginResponse {
  int statusCode;
  String msg;
  User? user;
  String? role;

  UsersLoginResponse({
    required this.statusCode,
    required this.msg,
    this.user,
    this.role,
  });
}

import '../../libs.dart';

class AdminRegisterResponse {
  int statusCode;
  String msg;
  User? user;
  String? role;
  Address? address;

  AdminRegisterResponse(
      {required this.statusCode, required this.msg, user, role, address});
}

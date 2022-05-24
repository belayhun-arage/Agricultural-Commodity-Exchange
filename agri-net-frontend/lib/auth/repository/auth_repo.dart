import '../../libs.dart';
import "package:http/http.dart";
import "dart:convert";

class AuthRepo {
  AuthProvider? provider;

  AuthRepo({@required this.provider});

  Future<UsersLoginResponse> loginAdmin(String email, String password) async {
    return await this.provider!.loginAdmin(email, password);
  }

  Future<MessageOnly> forgotPassword(String email) async {
    return this.provider!.forgotPassword(email);
  }
}

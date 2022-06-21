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

class AgentsResponse {
  int statusCode;
  String msg;
  List<Agent> agents;
  AgentsResponse(
      {required this.statusCode, required this.msg, required this.agents});

  factory AgentsResponse.fromJson(Map<String, dynamic> json) {
    return AgentsResponse(
        statusCode: json["status_code"],
        msg: json["msg"],
        agents: json["agents"] == null
            ? []
            : (json["agents"] as List<dynamic>)
                .map<Agent>((e) => Agent.fromJson(e as Map<String, dynamic>))
                .toList());
  }
}

class DeleteUserResponse {
  int statusCode;
  String msg;
  Map<String, String> errors;
  DeleteUserResponse(
      {required this.statusCode, required this.msg, required this.errors});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(
        statusCode: json["status_code"],
        msg: json["msg"],
        errors: json["errors"]);
  }
}

class AdminsResponse {
  int statusCode;
  String msg;
  List<Admin> admins;
  AdminsResponse(
      {required this.statusCode, required this.msg, required this.admins});

  factory AdminsResponse.fromJson(Map<String, dynamic> json) {
    return AdminsResponse(
        statusCode: json["status_code"],
        msg: json["msg"],
        admins: json["admins"] == null
            ? []
            : (json["admins"] as List<dynamic>)
                .map<Admin>(
                  (e) => Admin.fromJson(e as Map<String, dynamic>),
                )
                .toList());
  }
}

class MerchantsResponse {
  int statusCode;
  String msg;
  List<Merchant> merchants;
  MerchantsResponse(
      {required this.statusCode, required this.msg, required this.merchants});
  factory MerchantsResponse.fromJson(Map<String, dynamic> json) {
    return MerchantsResponse(
        statusCode: json["status_code"],
        msg: json["msg"],
        merchants: json["merchants"] == null
            ? []
            : (json["merchants"] as List<dynamic>)
                .map<Merchant>(
                  (e) => Merchant.fromJson(e as Map<String, dynamic>),
                )
                .toList());
  }
}

class SimpleResponse {
  int statusCode;
  String msg;

  SimpleResponse(
    this.statusCode,
    this.msg,
  );

  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    return SimpleResponse(
      json["status_code"] ?? 999,
      json["msg"] ?? "-",
    );
  }
}



import '../../libs.dart';

class MerchantRegResp {
  Merchant? merchant;
  int statusCode;
  String msg;
  MerchantRegResp({this.merchant, required this.statusCode, required this.msg});

  factory MerchantRegResp.fromJson(json) {
    return MerchantRegResp(
        merchant: json["merchant"],
        statusCode: json["status_code"],
        msg: json["msg"]);
  }
}

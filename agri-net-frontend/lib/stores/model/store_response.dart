import '../../libs.dart';

class NewStoreResponse {
  int statusCode;
  String msg;
  Store? newStore;
  NewStoreResponse(
      {required this.statusCode, required this.msg, this.newStore});
}

class StoresResponse {
  int statusCode;
  String msg;
  List<Store> stores;

  StoresResponse(
      {required this.statusCode, required this.msg, required this.stores});
  factory StoresResponse.fromJson(Map<String, dynamic> json) {
    return StoresResponse(
        statusCode: json["status_code"],
        msg: json["msg"],
        stores: json["stores"] == null
            ? []
            : (json["stores"] as List<dynamic>)
                .map<Store>((e) => Store.fromJson(e as Map<String, dynamic>))
                .toList());
  }
}

import '../../libs.dart';

class Merchant extends User {
  int storeCount;
  int postsCounte;
  int reg_by;
  Address address;
  Merchant(Map<String, dynamic> json, this.storeCount, this.postsCounte,
      this.reg_by, this.address)
      : super(
            id: json["id"] ?? 500,
            firstname: json["firstname"] ?? "",
            lastname: json["lastname"] ?? '',
            email: json["email"] ?? '',
            phone: json["phone"] ?? '',
            lang: json["lang"] ?? '',
            imgurl: json["imgUrl"] ?? '');

  factory Merchant.fromJson(json) {
    final merchant = Merchant(
        json,
        json["stores_count"] ?? 0,
        json["posts_count"] ?? 0,
        json["registered_by"] ?? 2,
        json["address"] != null
            ? Address.fromJson(json["address"])
            : Address(
                ID: 800,
                Kebele: "",
                City: "",
                Latitude: 0.0,
                Longitude: 0.0,
                Region: "",
                UniqueAddressName: "",
                Woreda: "",
                Zone: ""));
    return merchant;
  }
}

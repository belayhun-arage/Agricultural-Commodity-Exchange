import '../../libs.dart';

class Admin extends User {
  Address address;
  int merchantsCreated;
  int storesCreated;
  int createdBy;
  Admin(Map<String, dynamic> json, this.address, this.merchantsCreated,
      this.storesCreated, this.createdBy)
      : super(
            id: json["id"] ?? 0,
            firstname: json["firstname"] ?? '',
            lastname: json["lastname"] ?? '',
            email: json["email"] ?? '',
            phone: json["phone"] ?? '',
            lang: json["lang"] ?? 'amh',
            imgurl: json["imgUrl"] ?? "");

  factory Admin.fromJson(json) {
    final admin = Admin(
        json,
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
                Zone: ""),
        json["merchants_created"] ?? 0,
        json["stores_created"] ?? 0,
        json["created_by"] ?? 0);
    return admin;
  }
}

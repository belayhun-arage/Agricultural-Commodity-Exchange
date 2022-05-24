class Address {
  int ID;
  String Kebele;
  String Woreda;
  String City;
  String UniqueAddressName;
  String Region;
  String Zone;
  double Latitude;
  double Longitude;
  Address(this.ID, this.Kebele, this.City, this.Latitude, this.Longitude,
      this.Region, this.UniqueAddressName, this.Woreda, this.Zone);

  factory Address.fromJson(json) {
    return Address(
        json["id"],
        json["kebele"],
        json["city"],
        json["latitude"],
        json["longitude"],
        json["region"],
        json["unique_address"],
        json["woreda"],
        json["zone"]);
  }
}


class User {
  int id;
  String firstname;
  String lastname;
  String phone;
  String email;
  String lang;
  DateTime? createdAt;
  String imgurl;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.lang,
    this.createdAt,
    required this.imgurl,
  });

  User copyWith(
      {String? firstName,
      String? lastName,
      String? Email,
      String? Phone,
      String? NewImgUrl,
      String? Lang}) {
    return User(
        id: this.id,
        firstname: firstName ?? this.firstname,
        lastname: lastName ?? this.lastname,
        phone: Phone ?? this.phone,
        email: Email ?? this.email,
        lang: Lang ?? this.lang,
        imgurl: NewImgUrl ?? this.imgurl);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    int id = int.parse("${json['id']}");
    String fName = json["firstname"];
    String lName = json["lastname"];
    String phone = json["phone"] ?? '';
    String emaile = json["email"];
    String lang = json["lang"];
    String url = (json["imgurl"] ?? '');
    DateTime createdAt =
        DateTime.fromMillisecondsSinceEpoch((json["created_at"] ?? 0) * 1000);

    return User(
        id: id,
        firstname: fName,
        lastname: lName,
        phone: phone,
        email: emaile,
        lang: lang,
        imgurl: url,
        createdAt: createdAt);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "firstname": this.firstname,
      "lastname": this.lastname,
      "email": this.email,
      "phone": this.phone,
      "imgurl": this.imgurl,
      "lang": this.lang,
      "created_at": (this.createdAt!.millisecondsSinceEpoch) / 1000,
    };
  }
}

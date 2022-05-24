class UserPP {
  String image;
  String name;
  String email;
  String phone;
  String aboutMeDescription;

  // Constructor
  UserPP({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.aboutMeDescription,
  });

  UserPP copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      UserPP(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        aboutMeDescription: about ?? this.aboutMeDescription,
      );

  static UserPP fromJson(Map<String, dynamic> json) => UserPP(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        aboutMeDescription: json['about'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'about': aboutMeDescription,
        'phone': phone,
      };
}

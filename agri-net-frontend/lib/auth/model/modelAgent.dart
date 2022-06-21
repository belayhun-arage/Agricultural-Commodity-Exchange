// import '../../libs.dart';

// class Agent extends User {
//   Address address;
//   int postCount;
//   int registeredBy;
//   Agent(Map<String, dynamic> json, this.address, this.postCount,
//       this.registeredBy)
//       : super(
//             id: json["id"] ?? 999,
//             firstname: json["firstname"] ?? '',
//             lastname: json["lastname"] ?? '',
//             email: json["email"] ?? '',
//             phone: json["phone"] ?? '',
//             lang: json["lang"] ?? '',
//             imgurl: json["imgUrl"] ?? '');

//   factory Agent.fromJson(json) {
//     final agent = Agent(json, Address.fromJson(json["field_address"]),
//         json["posts_count"], json["registered_by"]);
//     return agent;
//   }
// }

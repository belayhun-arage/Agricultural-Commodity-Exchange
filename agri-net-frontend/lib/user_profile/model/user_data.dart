import 'dart:convert';

import '../../libs.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static UserPP myUser = UserPP(
    image: "assets/images/pp.jpg",
    name: 'Belayhun Arage',
    email: 'belayhun24arage@gmail.com',
    phone: '(+251) 949934511',
    aboutMeDescription:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat...',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserPP user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static UserPP getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : UserPP.fromJson(jsonDecode(json));
  }
}

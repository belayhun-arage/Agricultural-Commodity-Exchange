import "../../libs.dart";

class UserState {}

class UserStateInit extends UserState {}

class Authenticated extends UserState {
  User user;
  String role;
  Authenticated({required this.user, required this.role});
}

class NotAuthenticated extends UserState {
  String Msg;
  NotAuthenticated(this.Msg);
}

class UserLoginOnProgressState extends UserState {}

// AuthForgotPasswordInProgress ....
class UserForgotPasswordInProgressState extends UserState {}

class UserPasswordSentLoginAndChangePasswordState extends UserState {}

class AuthForgotPasswordRequestFailed extends UserState {
  String message;
  AuthForgotPasswordRequestFailed(this.message);
}

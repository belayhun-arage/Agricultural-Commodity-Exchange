import "../../libs.dart";

class AuthBlocState {}

class AuthStateInit extends AuthBlocState {}

class AuthAdminLoggedIn extends AuthBlocState {
  User user;
  String role;
  AuthAdminLoggedIn(this.user, this.role);
}

class AuthAdminLoginNotSuccesful extends AuthBlocState {
  String Msg;
  AuthAdminLoginNotSuccesful(this.Msg);
}

class AuthAdminLoginOnProgress extends AuthBlocState {}

// AuthForgotPasswordInProgress ....
class AuthForgotPasswordInProgress extends AuthBlocState {}

class AuthPasswordSentLoginAndChangePassword extends AuthBlocState {}

class AuthForgotPasswordRequestFailed extends AuthBlocState {
  String message;
  AuthForgotPasswordRequestFailed(this.message);
}

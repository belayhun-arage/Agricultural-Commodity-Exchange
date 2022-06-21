import "../../libs.dart";

class UserEvent {}

class UserLoginEvent extends UserEvent {
  String email;
  String password;
  UserLoginEvent(this.email, this.password);
}

class UserConfirmationEvent extends UserEvent {
  String phone;
  String password;
  UserConfirmationEvent(this.phone, this.password);
}

class UserForgotPasswordEvent extends UserEvent {
  String email;
  UserForgotPasswordEvent(this.email);
}

class UserLoginInProgressEvent extends UserEvent {}

class UserInitEvent extends UserEvent {}

class UserLoggedInEvent extends UserEvent {
  User state;
  String role;
  UserLoggedInEvent(this.state, this.role);
}

class UserLoginNotSuccesfulEvent extends UserEvent {
  String Msg;
  UserLoginNotSuccesfulEvent(this.Msg);
}

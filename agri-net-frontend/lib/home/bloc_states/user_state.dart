import "../../libs.dart";

class UsersState {}

class UsersLoadedState extends UsersState {
  Map<int, User> users;
  Map<int, Merchant> merchants = {};
  UsersLoadedState(this.users, {required this.merchants});
}

class UsersLoadFailedState extends UsersState {}

class UsersInit extends UsersState {}

class UsersLoading extends UsersState {}

import 'package:agri_net_frontend/auth/model/modelUser.dart';

class UserState {}

class UserLoggedInItState extends UserState {}

class UserLoggedInState extends UserState {
  User user;
  UserLoggedInState({required this.user});
}

class AllProductsState extends UserState {}

class UserProductsState extends UserState {}

class UserProfileState extends UserState {}

class UserNotificationState extends UserState {}


class UserWithNoRoleState extends UserState {}

class SomethingWentWrongState extends UserState {}

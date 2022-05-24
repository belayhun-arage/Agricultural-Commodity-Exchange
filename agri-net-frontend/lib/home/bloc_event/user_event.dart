import '../../libs.dart';

class UserEvent {}

class UserLoggedInItEvent extends UserEvent {}

class UserLoggedInEvent extends UserEvent {
  User user;
  UserLoggedInEvent({required this.user});
}

class SomethingWentWrongEvent extends UserEvent {}

class AllProductsEvent extends UserEvent {}

class UserProductsEvent extends UserEvent {}

class UserProfileEvent extends UserEvent {}

class UserNotificationEvent extends UserEvent {}

class UserLoggOutEvent extends UserEvent {}

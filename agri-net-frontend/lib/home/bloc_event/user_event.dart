
import "../../libs.dart";
class UsersEvent {}

class LoadUserByIDEvent extends UsersEvent {
  int id;
  LoadUserByIDEvent(this.id);
}


class LoadMerchantByStoreIDEvent extends UsersEvent {
  int storeID;
  LoadMerchantByStoreIDEvent(this.storeID);
} 

class AddUserInstanceEvent extends UsersEvent {
  User user;
  int? storeID;
  AddUserInstanceEvent(this.user , {this.storeID});
}

class AddUsersEvent extends UsersEvent {
  List<User> users;
  AddUsersEvent(this.users);
}
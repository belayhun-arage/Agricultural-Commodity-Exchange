import '../../libs.dart';

class AdminsEvent {}

class GetAllAdminsEvent extends AdminsEvent {}

class AllUsersRetrievedEvent extends AdminsEvent {
  List<User> usersList = [];
  AllUsersRetrievedEvent({required this.usersList});
}

class NoUserFound extends AdminsEvent {}

class CreateNewAdminEvent extends AdminsEvent {
  String firstname;
  String lastname;
  String phone;
  String email;
  String kebele;
  String woreda;
  String city;
  String unique_address;
  String region;
  String zone;
  double latitude;
  double longitude;
  CreateNewAdminEvent(
      {required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email,
      required this.city,
      required this.kebele,
      required this.woreda,
      required this.zone,
      required this.region,
      required this.unique_address,
      required this.latitude,
      required this.longitude});
}

class AdminCreatedEvent extends AdminsEvent {
  User user;
  AdminCreatedEvent({required this.user});
}

class FailedToCreateAdminEvent extends AdminsEvent {
  String msg;
  FailedToCreateAdminEvent({required this.msg});
}

class SomethingWrongEvent extends AdminsEvent {}

class GetAllMerchantsEvent extends AdminsEvent {}

class AllMerchantsFechedEvent extends AdminsEvent {
  List<Merchant> merchants;
  AllMerchantsFechedEvent({required this.merchants});
}

class CreatNewMerchantEvent extends AdminsEvent {
  String firstname;
  String lastname;
  String phone;
  String email;
  String kebele;
  String woreda;
  String city;
  String unique_address;
  String region;
  String zone;
  double latitude;
  double longitude;
  CreatNewMerchantEvent(
      {required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email,
      required this.city,
      required this.kebele,
      required this.woreda,
      required this.zone,
      required this.region,
      required this.unique_address,
      required this.latitude,
      required this.longitude});
}

class GetALlAgentsEvent extends AdminsEvent {}

class AllAgentsFechedEvent extends AdminsEvent {
  List<Agent> agents;
  AllAgentsFechedEvent({required this.agents});
}

class NewAgentCreatedEvent extends AdminsEvent {
  Agent agent;
  NewAgentCreatedEvent({required this.agent});
}

class CreatNewAgentEvent extends AdminsEvent {
  String firstname;
  String lastname;
  String phone;
  String email;
  String kebele;
  String woreda;
  String city;
  String unique_address;
  String region;
  String zone;
  double latitude;
  double longitude;
  CreatNewAgentEvent(
      {required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email,
      required this.city,
      required this.kebele,
      required this.woreda,
      required this.zone,
      required this.region,
      required this.unique_address,
      required this.latitude,
      required this.longitude});
}

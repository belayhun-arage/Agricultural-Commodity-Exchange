import '../../libs.dart';

class AdminsEvent {}

class GetAllAdminsEvent extends AdminsEvent {}

class AllAdminsRetrievedEvent extends AdminsEvent {
  List<Admin> adminsList = [];
  AllAdminsRetrievedEvent({required this.adminsList});
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
  Admin admin;
  AdminCreatedEvent({required this.admin});
}

class FailedToCreateAdminEvent extends AdminsEvent {
  String msg;
  FailedToCreateAdminEvent({required this.msg});
}

class FailedToCreateAgentEvent extends AdminsEvent {
  String msg;
  FailedToCreateAgentEvent({required this.msg});
}

class SomethingWrongEvent extends AdminsEvent {}

class GetAllMerchantsEvent extends AdminsEvent {
  Admin admin;
  GetAllMerchantsEvent({required this.admin});
}

class AllMerchantsFechedEvent extends AdminsEvent {
  List<Merchant> merchants;
  AllMerchantsFechedEvent({required this.merchants});
}

class CreatNewMerchantEvent extends AdminsEvent {
  String firstname;
  String lastname;
  String phone;
  String? email;
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
      this.email,
      required this.city,
      required this.kebele,
      required this.woreda,
      required this.zone,
      required this.region,
      required this.unique_address,
      required this.latitude,
      required this.longitude});
}

class GetAllAgentsEvent extends AdminsEvent {
  Admin admin;
  GetAllAgentsEvent({required this.admin});
}

class AllAgentsFechedEvent extends AdminsEvent {
  List<Agent> agents;
  AllAgentsFechedEvent({required this.agents});
}

class NewAgentCreatedEvent extends AdminsEvent {
  Agent agent;
  NewAgentCreatedEvent({required this.agent});
}

class NewMerchantCreatedEvent extends AdminsEvent {
  Merchant merchant;
  NewMerchantCreatedEvent({required this.merchant});
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

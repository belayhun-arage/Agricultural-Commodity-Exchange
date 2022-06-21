import '../../libs.dart';

class AdminsEvent {}

class AdminsInIt extends AdminsEvent {}

class LoadAdminsInIt extends AdminsEvent {}

class AllAdminsRetrievedEvent extends AdminsEvent {
  List<Admin> adminsList = [];
  AllAdminsRetrievedEvent({required this.adminsList});
}

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

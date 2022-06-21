class AgentsEvent {}

class LoadMyAgentsEvent extends AgentsEvent {
  int adminID;
  LoadMyAgentsEvent({required this.adminID});
}

class NewAgentEvent extends AgentsEvent {
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
  NewAgentEvent(
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

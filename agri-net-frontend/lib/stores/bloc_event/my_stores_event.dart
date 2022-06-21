import 'package:agri_net_frontend/libs.dart';

class StoreEvent {}

class LoadMyStoresEvent extends StoreEvent {
  int ownerId;
  LoadMyStoresEvent({required this.ownerId});
}

class CreateNewStoreEvent extends StoreEvent {
  int ownerID;
  String storeName;
  String kebele;
  String woreda;
  String city;
  String unique_address;
  String region;
  String zone;
  double latitude;
  double longitude;

  CreateNewStoreEvent(
      {required this.ownerID,
      required this.storeName,
      required this.city,
      required this.kebele,
      required this.woreda,
      required this.zone,
      required this.region,
      required this.unique_address,
      required this.latitude,
      required this.longitude});
}

class NewStoreCreatedEvent extends StoreEvent {
  Store newStore;
  NewStoreCreatedEvent({required this.newStore});
}

class FailedToCreateNewStore extends StoreEvent {
  String msg;
  FailedToCreateNewStore({required this.msg});
}

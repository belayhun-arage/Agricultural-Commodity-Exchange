import 'package:agri_net_frontend/agents/bloc_state/bloc_state.dart';

class MerchantsEvent {}

class LoadMyMerchantsEvent extends MerchantsEvent {
  int adminID;
  LoadMyMerchantsEvent({required this.adminID});
}

class DeleteMerchantEvent extends MerchantsEvent {
  int userID;
  DeleteMerchantEvent({required this.userID});
}

class AddNewMerchant extends MerchantsEvent {
  Merchant merchant;
  AddNewMerchant({required this.merchant});
}

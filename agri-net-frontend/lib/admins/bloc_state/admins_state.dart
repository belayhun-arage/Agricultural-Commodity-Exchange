import 'package:agri_net_frontend/auth/model/modelUser.dart';
import 'package:agri_net_frontend/libs.dart';

class AdminsState {}

// Super-Admin
class GetAllAdminsState extends AdminsState {}

class LoadingUsersState extends AdminsState {}

class AllAdminsRetrievedState extends AdminsState {
  List<User> usersList = [];
  AllAdminsRetrievedState({required this.usersList});
}

class NoAdminFoundState extends AdminsState {}

class CreateNewUserState extends AdminsState {}

class NewAdminCreatedState extends AdminsState {
  User user;
  NewAdminCreatedState({required this.user});
}

class FailedToCreateAdminState extends AdminsState {
  String msg;
  FailedToCreateAdminState({required this.msg});
}

class SthWentWrongState extends AdminsState {}

class AdminsLoadingFailed extends AdminsState {}

// ADMIN
class GetAllMerchantsState extends AdminsState {}

class AllMerchantsFechedState extends AdminsState {
  List<Merchant> merchants;
  AllMerchantsFechedState({required this.merchants});
}

class FailedToFechMerchntsState extends AdminsState {
  String msg;
  FailedToFechMerchntsState({required this.msg});
}

class NoMerchantsFoundState extends AdminsState {}

class NewMerchantPostedState extends AdminsState {
  MerchantRegResp newMerchant;
  NewMerchantPostedState({required this.newMerchant});
}

class FailedToCreateNewMerchantState extends AdminsState {}

// AGENTS

class GetAllAgentsState extends AdminsState {}

class AllAgentsFechedState extends AdminsState {
  List<Agent> agentsList;
  AllAgentsFechedState({required this.agentsList});
}

class NoAgentsFoundState extends AdminsState {}

class FailedToFechAgentsState extends AdminsState {}

class NewAgentCreatedState extends AdminsState {
  Agent agent;
  NewAgentCreatedState({required this.agent});
}

class FailedToCreateNewAgentState extends AdminsState {}

import '../../libs.dart';

class AdminsBloc extends Bloc<AdminsEvent, AdminsState>
    implements Cubit<AdminsState> {
  AdminsRepo adminsRepo;

  AdminsBloc({required this.adminsRepo}) : super(GetAllAdminsState());

  @override
  Stream<AdminsState> mapEventToState(AdminsEvent adminsEvent) async* {
    if (adminsEvent is GetAllAdminsEvent) {
      final admins = await adminsRepo.getAdmins();
      if (admins.length > 0) {
        yield AllAdminsRetrievedState(adminsList: admins);
        print("Admins Loading Was succesful \n\n\n\n");
      } else {
        yield AdminsLoadingFailed();
      }
    }
    if (adminsEvent is GetAllMerchantsEvent) {
      final merchants = await adminsRepo.getMerchants(adminsEvent.admin);
      if (merchants.length > 0) {
        yield AllMerchantsFechedState(merchants: merchants);
      }
      if (merchants.length == 0) {
        yield NoMerchantsFoundState(msg: "You have no merchants record yet.");
      }
    }
    if (adminsEvent is GetAllAgentsEvent) {
      final agents = await adminsRepo.getAgents(adminsEvent.admin.id);
      if (agents.length > 0) {
        yield AllAgentsFechedState(agentsList: agents);
      }
      if (agents.length == 0) {
        yield NoAgentsFoundState();
      }
    }
    if (adminsEvent is CreateNewAdminEvent) {
      yield CreateNewUserState();
    }
    if (adminsEvent is NewMerchantCreatedEvent) {
      yield NewMerchantPostedState(newMerchant: adminsEvent.merchant);
    }
    if (adminsEvent is AdminCreatedEvent) {
      yield NewAdminCreatedState(admin: adminsEvent.admin);
    }
    if (adminsEvent is FailedToCreateAdminEvent) {
      yield FailedToCreateAdminState(msg: adminsEvent.msg);
    }
    if (adminsEvent is NewAgentCreatedEvent) {
      yield NewAgentCreatedState(agent: adminsEvent.agent);
    }
    if (adminsEvent is FailedToCreateAgentEvent) {
      yield FailedToCreateNewAgentState();
    }
  }

  Future<AdminsState> registerAdmin(
      CreateNewAdminEvent createNewAdminEvent) async {
    final admin = await adminsRepo.createNewAdmin(
        createNewAdminEvent.firstname,
        createNewAdminEvent.lastname,
        createNewAdminEvent.email,
        createNewAdminEvent.phone,
        createNewAdminEvent.city,
        createNewAdminEvent.kebele,
        createNewAdminEvent.woreda,
        createNewAdminEvent.zone,
        createNewAdminEvent.region,
        createNewAdminEvent.unique_address,
        createNewAdminEvent.latitude,
        createNewAdminEvent.longitude);
    if (admin.user != null) {
      this.mapEventToState(AdminCreatedEvent(admin: admin.user! as Admin));
      final state = NewAdminCreatedState(admin: admin.user! as Admin);
      return state;
    }
    this.mapEventToState(FailedToCreateAdminEvent(msg: admin.msg));
    final state = FailedToCreateAdminState(msg: admin.msg);
    return state;
  }

  Future<AdminsState> registerMerchant(
      CreatNewMerchantEvent creatNewMerchantEvent) async {
    final newMerchantResponce = await adminsRepo.creatNewMerchant(
        creatNewMerchantEvent.firstname,
        creatNewMerchantEvent.lastname,
        creatNewMerchantEvent.email!,
        creatNewMerchantEvent.phone,
        creatNewMerchantEvent.city,
        creatNewMerchantEvent.kebele,
        creatNewMerchantEvent.woreda,
        creatNewMerchantEvent.zone,
        creatNewMerchantEvent.region,
        creatNewMerchantEvent.unique_address,
        creatNewMerchantEvent.latitude,
        creatNewMerchantEvent.longitude);
    if (newMerchantResponce.user != null) {
      this.mapEventToState(NewMerchantCreatedEvent(
          merchant: newMerchantResponce.user! as Merchant));
      final state = NewMerchantPostedState(
          newMerchant: newMerchantResponce.user! as Merchant);
      return state;
    }
    this.mapEventToState(
        FailedToCreateAdminEvent(msg: newMerchantResponce.msg));
    final state = FailedToCreateAdminState(msg: newMerchantResponce.msg);
    return state;
  }

  Future<AdminsState> registerAgent(
      CreatNewAgentEvent creatNewAgentEvent) async {
    final newAgentResponse = await adminsRepo.creatNewAgent(
        creatNewAgentEvent.firstname,
        creatNewAgentEvent.lastname,
        creatNewAgentEvent.email,
        creatNewAgentEvent.phone,
        creatNewAgentEvent.city,
        creatNewAgentEvent.kebele,
        creatNewAgentEvent.woreda,
        creatNewAgentEvent.zone,
        creatNewAgentEvent.region,
        creatNewAgentEvent.unique_address,
        creatNewAgentEvent.latitude,
        creatNewAgentEvent.longitude);
    if (newAgentResponse.user != null) {
      this.mapEventToState(
          NewAgentCreatedEvent(agent: newAgentResponse.user! as Agent));
      final state =
          NewAgentCreatedState(agent: newAgentResponse.user! as Agent);
      return state;
    }
    this.mapEventToState(FailedToCreateAgentEvent(msg: newAgentResponse.msg));
    final state = FailedToCreateNewAgentState();
    return state;
  }
}

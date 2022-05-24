import 'package:agri_net_frontend/admins/admins.dart';

import '../../libs.dart';

class AdminsBloc extends Bloc<AdminsEvent, AdminsState>
    implements Cubit<AdminsState> {
  AdminsRepo adminsRepo;
  AdminsBloc({required this.adminsRepo}) : super(GetAllAdminsState());

  @override
  Stream<AdminsState> mapEventToState(AdminsEvent usersEvent) async* {
    if (usersEvent is GetAllAdminsEvent) {
      final admins = await adminsRepo.getAdmins();
      if (admins.length > 0) {
        yield AllAdminsRetrievedState(usersList: admins);
        print("Admins Loading Was succesful \n\n\n\n");
      } else {
        yield AdminsLoadingFailed();
      }
    }
    if (usersEvent is GetALlAgentsEvent) {
      final agents = await adminsRepo.getAgents();
      if (agents.length > 0) {
        yield AllAgentsFechedState(agentsList: agents);
      } else {
        yield FailedToFechAgentsState();
      }
    }
    if (usersEvent is GetAllMerchantsEvent) {
      final merchants = await adminsRepo.getMerchants();
      if (merchants.length > 0) {
        yield AllMerchantsFechedState(merchants: merchants);
      } else {
        yield FailedToFechMerchntsState(msg: "Erroe while feching merchants");
      }
    }
    if (usersEvent is CreateNewAdminEvent) {
      yield CreateNewUserState();
    }
    if (usersEvent is AdminCreatedEvent) {
      yield NewAdminCreatedState(user: usersEvent.user);
    }
    if (usersEvent is FailedToCreateAdminEvent) {
      yield FailedToCreateAdminState(msg: usersEvent.msg);
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
      this.mapEventToState(AdminCreatedEvent(user: admin.user!));
      final state = NewAdminCreatedState(user: admin.user!);
      return state;
    }
    this.mapEventToState(FailedToCreateAdminEvent(msg: admin.msg));
    final state = FailedToCreateAdminState(msg: admin.msg);
    return state;
  }
}

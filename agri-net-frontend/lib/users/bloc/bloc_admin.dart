import '../../libs.dart';

class AdminsBloc extends Bloc<AdminsEvent, AdminsState>
    implements Cubit<AdminsState> {
  AdminsRepo adminsRepo;

  AdminsBloc({required this.adminsRepo}) : super(AdminsStateInIt()) {
    on<LoadAdminsInIt>((event, emit) async {
      if (!(this.state is AdminsLoadedState)) {
        emit(LoadingAdminsState());
      }
      final response = await adminsRepo.getAdmins();
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (this.state is AdminsLoadedState) {
          (this.state as AdminsLoadedState).adminsList.addAll(response.admins);
          emit(this.state);
        } else {
          emit(AdminsLoadedState(adminsList: response.admins));
        }
      } else {
        emit(AdminsLoadingFailed(
            statusCode: response.statusCode, msg: response.msg));
      }
    });
  }

  Future<UserRegisterResponse> registerAdmin(
      CreateNewAdminEvent createNewAdminEvent) async {
    final adminRegRespo = await adminsRepo.createNewAdmin(
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
    return adminRegRespo;
  }
}

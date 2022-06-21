import '../../libs.dart';

class AdminsRepo {
  UserProvider adminsProvider;
  AdminsRepo({required this.adminsProvider});

  Future<List<Admin>> getAdmins() {
    return adminsProvider.getAdmins();
  }

  Future<List<Merchant>> getMerchants(Admin admin) {
    return adminsProvider.getMerchants(admin);
  }

  Future<List<Agent>> getAgents(int id) {
    return adminsProvider.getAgents(id);
  }

  Future<UserRegisterResponse> creatNewMerchant(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String uniqueAddress,
    String region,
    String zone,
    double latitude,
    double longitude,
  ) async {
    return await adminsProvider.createNewMerchant(
        firstname,
        lastname,
        email,
        phone,
        kebele,
        woreda,
        city,
        uniqueAddress,
        region,
        zone,
        latitude,
        longitude);
  }

  Future<UserRegisterResponse> creatNewAgent(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String uniqueAddress,
    String region,
    String zone,
    double latitude,
    double longitude,
  ) async {
    return await adminsProvider.createNewAgent(
        firstname,
        lastname,
        email,
        phone,
        kebele,
        woreda,
        city,
        uniqueAddress,
        region,
        zone,
        latitude,
        longitude);
  }

  Future<UserRegisterResponse> createNewAdmin(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String uniqueAddress,
    String region,
    String zone,
    double latitude,
    double longitude,
  ) {
    return adminsProvider.createNewAdmin(
      firstname,
      lastname,
      email,
      phone,
      kebele,
      woreda,
      city,
      uniqueAddress,
      region,
      zone,
      latitude,
      longitude,
    );
  }
}

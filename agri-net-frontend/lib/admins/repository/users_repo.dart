import 'package:agri_net_frontend/admins/model/models.dart';
import 'package:agri_net_frontend/admins/admins.dart';

import '../../libs.dart';

class AdminsRepo {
  AdminsProvider adminsProvider;
  AdminsRepo({required this.adminsProvider});

  Future<List<User>> getAdmins() {
    return adminsProvider.getAdmins();
  }

  Future<List<Merchant>> getMerchants() {
    return adminsProvider.getMerchants();
  }

  Future<List<Agent>> getAgents() {
    return adminsProvider.getAgents();
  }

  Future<AdminRegisterResponse> createNewAdmin(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String unique_address,
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
      unique_address,
      region,
      zone,
      latitude,
      longitude,
    );
  }
}

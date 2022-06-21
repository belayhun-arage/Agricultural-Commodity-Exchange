import '../../libs.dart';
import '../data_provider/admin_dataProvider.dart';

class AdminsRepo {
  AdminProvider adminsProvider;
  AdminsRepo({required this.adminsProvider});

  Future<AdminsResponse> getAdmins() async {
    return await adminsProvider.getAdmins();
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

  // Future<DeleteUserResponse> deleteUser(int id) async {
  //   return await adminsProvider.deleteUser(id);
  // }
}

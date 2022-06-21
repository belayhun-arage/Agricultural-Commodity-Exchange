import '../../libs.dart';

class MerchantRepo {
  MerchantProvider merchantProvider;
  MerchantRepo({required this.merchantProvider});

  Future<MerchantsResponse> getMerchants(int id) {
    return merchantProvider.getMerchants(id);
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
    return await merchantProvider.createNewMerchant(
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

  Future<DeleteUserResponse> deleteMerchant(int id) async {
    return await merchantProvider.deleteMerchant(id);
  }
}

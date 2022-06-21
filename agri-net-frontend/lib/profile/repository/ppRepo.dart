import 'package:agri_net_frontend/profile/profile.dart';
import '../../libs.dart';

class ProfileRepository {
  ProfileProvider profileProvider;
  ProfileRepository({required this.profileProvider});
  static int lock = 0;
  Future<ImageUploadResponse> uploadImage(File file, int id) async {
    if (lock > 0) {
      Future.delayed(Duration(seconds: 1));
      return ImageUploadResponse(id, 2000, '', msg: "Uploading");
      // return ImageUploadResponse(statusCode: 1000, products: [], msg: "locked");
    }
    lock += 1;
    final response = await this.profileProvider.uploadImage(file, id);
    lock -= 1;
    return response;
  }

  Future<DeletePPResponse> deletePP() async {
    return await profileProvider.deletePP();
  }

  Future<void> uploadImage2(File file, int id) async {
    if (lock > 0) {
      Future.delayed(Duration(seconds: 1));
      // return ImageUploadResponse(id, 2000, '', msg: "Uploading");
      // return ImageUploadResponse(statusCode: 1000, products: [], msg: "locked");
    }
    lock += 1;
    final response = await this.profileProvider.uploadImage2(file, id);
    lock -= 1;
    //
  }
}

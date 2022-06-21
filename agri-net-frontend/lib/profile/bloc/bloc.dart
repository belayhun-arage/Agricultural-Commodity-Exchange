import 'package:http/http.dart';

import '../../libs.dart';

class ProfileBLoc extends Bloc<ProfileEvent, ProfileState>
    implements Cubit<ProfileState> {
  ProfileBLoc(
      {required User user,
      required bool isCurrentUser,
      required this.profileRepository})
      : super(ProfileState(user: user, isCurrentUser: isCurrentUser));
  ImagePicker picker = ImagePicker();
  ProfileRepository profileRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent profileEvent) async* {
    if (profileEvent is ChangeAvatarRequest) {
      yield state.copyWith(imageSourceActionSheetIsVisible: true);
    }
    if (profileEvent is DeletePPEvent) {
      final response = await profileRepository.deletePP();
      if (response.statusCode == 200 || response.statusCode == 201) {
        yield state.copyWith(avatorPath: "");
        yield state.copyWith(imageSourceActionSheetIsVisible: false);
      }
    }
    if (profileEvent is OpenImagePicker) {
      yield state.copyWith(imageSourceActionSheetIsVisible: false);
      try {
        XFile pickedImage = await picker.pickImage(
            source: profileEvent.imageSource,
            imageQuality: 50,
            maxHeight: 500,
            maxWidth: 500) as XFile;
        File imageFile = File(pickedImage.path);
        var respo = await profileRepository.uploadImage(
            imageFile, profileEvent.user.id);
        if (respo.statusCode == 200 ||
            respo.statusCode == 201 && respo.imgurl != "") {
          yield state.copyWith(avatorPath: respo.imgurl);
          yield state.copyWith(imageSourceActionSheetIsVisible: false);
        }
      } catch (exception) {
        print(
            "Exceptionooooooooooo\nfrom\blocccccccccccccccccccccccccccccccccccccccc");
        Exception(exception);
      }
    }
  }
}

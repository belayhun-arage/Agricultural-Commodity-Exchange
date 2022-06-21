import '../../libs.dart';

class ProfileState {
  final User user;
  final String? avatorPath;
  final bool isCurrentUser;
  final bool? imageSourceActionSheetIsVisible;

  ProfileState(
      {required this.user,
      required this.isCurrentUser,
      this.avatorPath,
      this.imageSourceActionSheetIsVisible});

  ProfileState copyWith(
      {User? user,
      bool? isCurrentUser,
      String? avatorPath,
      bool? imageSourceActionSheetIsVisible}) {
    return ProfileState(
        user: user ?? this.user,
        isCurrentUser: isCurrentUser ?? this.isCurrentUser,
        avatorPath: avatorPath ?? '',
        imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
            this.imageSourceActionSheetIsVisible);
  }
}

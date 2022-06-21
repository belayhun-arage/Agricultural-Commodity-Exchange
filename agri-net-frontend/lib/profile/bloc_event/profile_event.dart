import '../../libs.dart';

abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {
  ImageSource imageSource;
  User user;
  OpenImagePicker({required this.imageSource, required this.user});
}

class ImageProvided extends ProfileEvent {
  final User user;
  final File image;

  ImageProvided({required this.user, required this.image});
}

class ProfileUpdatedSuccess extends ProfileEvent {
  int statusCode;
  String msg;
  ProfileUpdatedSuccess({required this.statusCode, required this.msg});
}

class ProfileUpdatedFailed extends ProfileEvent {
  int statusCode;
  String msg;
  ProfileUpdatedFailed({required this.statusCode, required this.msg});
}

class SaveProfileChanges extends ProfileEvent {
  User user;
  SaveProfileChanges({required this.user});
}

class DeletePPEvent extends ProfileEvent {}

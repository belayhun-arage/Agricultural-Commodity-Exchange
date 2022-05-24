import '../../libs.dart';

class UserBloc extends Bloc<UserEvent, UserState> implements Cubit<UserState> {
  UserBloc({required this.userRepo}) : super(UserLoggedInItState());
  final UserRepo userRepo;

  Stream<UserState> mapEventToState(UserEvent userEvent) async* {
    if (userEvent is UserLoggedInItEvent) {
      yield (UserLoggedInItState());
    }
    if (userEvent is UserLoggedInEvent) {
      yield (UserLoggedInState(user: userEvent.user));
    }
    if (userEvent is AllProductsEvent) {
      yield (UserProfileState());
    }
    if (userEvent is UserNotificationState) {
      yield (UserNotificationState());
    }
    ;
    if (userEvent is UserProfileEvent) {
      yield (UserProductsState());
    }
    if (userEvent is SomethingWentWrongEvent) {
      yield (SomethingWentWrongState());
    }
  }

  // Future<UserState> myProduct(AllProductsEvent event) {

  // }
}

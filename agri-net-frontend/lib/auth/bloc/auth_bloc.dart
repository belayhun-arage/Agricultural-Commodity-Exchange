import '../../libs.dart';

class UserBloc extends Bloc<UserEvent, UserState> implements Cubit<UserState> {
  UserBloc({required this.repo}) : super(UserStateInit());
  final UserRepo repo;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoginInProgressEvent) {
      yield (UserLoginOnProgressState());
    } else if (event is UserInitEvent) {
      yield (UserStateInit());
    } else if (event is UserLoggedInEvent) {
      StaticDataStore.ID = event.state.id;
      yield Authenticated(user: event.state, role: event.role);
    } else if (event is UserLoginNotSuccesfulEvent) {
      yield NotAuthenticated(event.Msg);
    } else if (event is UserForgotPasswordEvent) {
      yield (UserForgotPasswordInProgressState());
      final messageOnly = await repo.forgotPassword(event.email);
      if (messageOnly.succesful) {
        yield UserPasswordSentLoginAndChangePasswordState();
      } else {
        yield AuthForgotPasswordRequestFailed(messageOnly.msg);
      }
    }
  }

  Future<UserState> confirmYourAccount(UserConfirmationEvent  event) async {
    this.mapEventToState(UserLoginInProgressEvent());
    final thestate = await repo.confirmUserByPhone(event.phone, event.password);
    this.mapEventToState(UserInitEvent());
    if (thestate.user != null && thestate.role != null) {
      final val = Authenticated(user: thestate.user!, role: thestate.role!);
      this.mapEventToState(UserLoggedInEvent(val.user, val.role));
      return (Authenticated(user: thestate.user!, role: thestate.role!));
    }
    final val = NotAuthenticated(thestate.msg);
    this.mapEventToState(UserLoginNotSuccesfulEvent(val.Msg));
    return val;
  }

  Future<UserState> login(UserLoginEvent event) async {
    this.mapEventToState(UserLoginInProgressEvent());
    final thestate = await repo.loginAdmin(event.email, event.password);
    this.mapEventToState(UserInitEvent());
    if (thestate.user != null && thestate.role != null) {
      final val = Authenticated(user: thestate.user!, role: thestate.role!);
      this.mapEventToState(UserLoggedInEvent(val.user, val.role));
      return (Authenticated(user: thestate.user!, role: thestate.role!));
    }
    final val = NotAuthenticated(thestate.msg);
    this.mapEventToState(UserLoginNotSuccesfulEvent(val.Msg));
    return val;
  }
}

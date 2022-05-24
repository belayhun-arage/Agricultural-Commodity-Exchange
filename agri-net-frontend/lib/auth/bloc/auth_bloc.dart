import '../../libs.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState>
    implements Cubit<AuthBlocState> {
  AuthBloc({required this.repo}) : super(AuthStateInit());
  final AuthRepo repo;

  @override
  Stream<AuthBlocState> mapEventToState(AuthEvent event) async* {
    if (event is AdminLoginInProgressEvent) {
      yield (AuthAdminLoginOnProgress());
    } else if (event is AuthStateInitEvent) {
      yield (AuthStateInit());
    } else if (event is AuthAdminLoggedInEvent) {
      yield AuthAdminLoggedIn(event.state, event.role);
    } else if (event is AuthAdminLoginNotSuccesfulEvent) {
      yield AuthAdminLoginNotSuccesful(event.Msg);
    } else if (event is AuthForgotPasswordEvent) {
      yield (AuthForgotPasswordInProgress());
      final messageOnly = await repo.forgotPassword(event.email);
      if (messageOnly.succesful) {
        yield AuthPasswordSentLoginAndChangePassword();
      } else {
        yield AuthForgotPasswordRequestFailed(messageOnly.msg);
      }
    }
  }

  Future<AuthBlocState> login(AuthLoginEvent event) async {
    this.mapEventToState(AdminLoginInProgressEvent());
    final thestate = await repo.loginAdmin(event.email, event.password);
    this.mapEventToState(AuthStateInitEvent());
    if (thestate.user != null && thestate.role != null) {
      final val = AuthAdminLoggedIn(thestate.user!, thestate.role!);
      this.mapEventToState(AuthAdminLoggedInEvent(val.user, val.role));
      return (AuthAdminLoggedIn(thestate.user!, thestate.role!));
    }
    final val = AuthAdminLoginNotSuccesful(thestate.msg);
    this.mapEventToState(AuthAdminLoginNotSuccesfulEvent(val.Msg));
    return val;
  }
}

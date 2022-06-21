import "../../libs.dart";

class NotificationsBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository repo;
  NotificationsBloc(this.repo) : super(NotificationsInit()) {
    on<NotificationsLoadEvent>((event, emit) async {
      final response = await this.repo.getMyTransactionNotifications();
      hoolders -= 1;
      if (response.statusCode == 200) {
        final dstate =
            NotificationsLoadSuccess(response.transactionNotifications);
        dstate.generateCount();
        emit(dstate);
      } else {
        if (!(this.state is NotificationsLoadSuccess)) {
          emit(NotificationsLoadFailure());
        }
      }
    });
  }

  bool looping = true;
  void stopTransactionNotificationsLoop() {
    looping = false;
    hoolders -= 1;
  }

  static int hoolders = 0;
  Future<void> startLoadTransactionNotificationsLoop() async {
    if (hoolders >= 1) {
      return;
    }
    hoolders += 1;
    this.looping = true;
    while (looping) {
      await Future.delayed(Duration(seconds: 30), () {
        this.add(NotificationsLoadEvent());
      });
      await Future.delayed(Duration(seconds: 20), () {});
    }
  }

  Future<SimpleResponse> declineTransaction(int transactionID) async {
    final result = await this.repo.declineTransaction(transactionID);
    if (result.statusCode == 200) {
      this.add(NotificationsLoadEvent());
    }
    return result;
  }


  Future<TransactionResponse>  amendmentRequest(TransactionInputAmend input ) async {
    final result = await this.repo.amendmentRequest(input);
    if (result.statusCode == 200) {
      this.add(NotificationsLoadEvent());
    }
    return result;
  }

  Future<TransactionResponse>  amendTheRequest(TransactionInputAmend input ) async {
    final result = await this.repo.amendTheRequest(input);
    if (result.statusCode == 200) {
      this.add(NotificationsLoadEvent());
    }
    return result;
  }


  Future<TransactionResponse>  acceptTransactionAmendment(int transactionRequestID) async {
    final result = await this.repo.acceptTransactionAmendment(transactionRequestID);
    if (result.statusCode == 200) {
      this.add(NotificationsLoadEvent());
    }
    return result;
  }
  

}

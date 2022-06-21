import "../../libs.dart";

class NotificationRepository {
  NotificationProvider provider;

  NotificationRepository(this.provider);

  Future<TransactionNotifications> getMyTransactionNotifications() async {
    return this.provider.getMyTransactionNotifications();
  }

  Future<SimpleResponse> declineTransaction(int transactionID) async { 
    return this.provider.declineTransaction(transactionID);
  }

  Future<TransactionResponse>  amendmentRequest(TransactionInputAmend input ) async {
    return this.provider.amendmentRequest(input);
  }

  Future<TransactionResponse>  amendTheRequest(TransactionInputAmend input ) async {
    return this.provider.amendTheRequest(input);
  }

  Future<TransactionResponse>  acceptTransactionAmendment(int transactionRequestID) async {
    return this.provider.acceptTransactionAmendment(transactionRequestID);
  }


}

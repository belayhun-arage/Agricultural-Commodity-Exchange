import "../../libs.dart";

class TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionInit extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  List<Transaction> transactions;
  TransactionsLoaded(
    this.transactions,
  );


  Transaction? getTransactionByID(int id) {
    for (final transaction in this.transactions){
      if (transaction.transactionId == id){
        return transaction;
      }
    }
    return null;
  }
}

class TransactionsLoadingFailed extends TransactionState {
  int statusCode;
  String? msg;

  TransactionsLoadingFailed(this.statusCode, this.msg);
}

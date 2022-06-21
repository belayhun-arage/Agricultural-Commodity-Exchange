
import "../../libs.dart";

class TransactionRepo {

  TransactionProvider provider;
  TransactionRepo(this.provider);
  

  Future<MyTransactionsResponse>  getMyTransactions() async {
    return await this.provider.getMyTransactions();
  }


  Future<TransactionResponse> createTransaction(TransactionInput input ) async {
    return await this.provider.createTransaction(input);
  }
}
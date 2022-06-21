import "../../libs.dart";

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionRepo repo;
  TransactionBloc(this.repo) : super(TransactionInit()) {
    on<TransactionLoadEvent>(
      (event, emit) async {
        if (!(this.state is TransactionsLoaded)) {
          emit(TransactionLoading());
        }
        final transactionsResponse = await this.repo.getMyTransactions();
        if (transactionsResponse.statusCode == 200) {
          emit(TransactionsLoaded(transactionsResponse.transactions));
        } else if (!(this.state is TransactionsLoaded)) {
          emit(TransactionsLoadingFailed(transactionsResponse.statusCode, ""));
        }
      },
    );

    on<TransactionAddEvent>((event, emit) async {
      if (this.state is TransactionsLoaded) {
        (this.state as TransactionsLoaded).transactions.add(event.transaction);
      } else {
        emit(TransactionsLoaded([event.transaction]));
      }
    });

    // --
    //
  }

  Future<TransactionResponse> createTransaction(TransactionInput input) async {
    final transactionResponse = await this.repo.createTransaction(input);
    if (transactionResponse.statusCode == 200 ||
        transactionResponse.statusCode == 201) {
      this.add(TransactionAddEvent(transactionResponse.transaction!));
    }
    return transactionResponse;
  }

  bool looping = true;
  void stopLoop() {
    looping = false;
    hoolders -= 1;
  }

  static int hoolders = 0;
  Future<void> startLoadTransactionsLoop() async {
    if (hoolders >= 1) {
      return;
    }
    hoolders += 1;
    this.looping = true;
    while (looping) {
      await Future.delayed(Duration(minutes: 1), () {
        print("Loading ...");
        this.add(TransactionLoadEvent());
      });
      await Future.delayed(Duration(seconds: 40), () {});
    }
  }
}

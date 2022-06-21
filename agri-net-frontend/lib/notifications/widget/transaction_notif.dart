import '../../libs.dart';

class TransactionNotificationView extends StatefulWidget {
  const TransactionNotificationView({Key? key}) : super(key: key);

  @override
  State<TransactionNotificationView> createState() =>
      _TransactionNotificationState();
}

class _TransactionNotificationState extends State<TransactionNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: BlocBuilder<NotificationsBloc, NotificationState>(
          builder: (context, state) {
        if (state is NotificationsLoadSuccess) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.transactions.map<Widget>((e) {
                if (e.transactionRequest != null) {
                  return ((context.watch<NotificationsBloc>().state
                              is NotificationsLoadSuccess) &&
                          (context.watch<TransactionBloc>().state
                              is TransactionsLoaded) &&
                          (context.watch<TransactionBloc>().state
                                      as TransactionsLoaded)
                                  .getTransactionByID(e.transactionID) !=
                              null &&
                          e.transactionRequest != null)
                      ? TransactionNotificationItem(
                          (context.watch<TransactionBloc>().state
                                  as TransactionsLoaded)
                              .getTransactionByID(e.transactionID)!,
                          e.transactionRequest!)
                      : SizedBox();
                } else {
                  return SizedBox();
                }
              }).toList(),
            ),
          );
        } else if (state is NotificationsInit) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Text(
                    " Notification is not loaded ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.replay,
                ),
                onPressed: () {
                  //
                },
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Notification Loading Failed",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

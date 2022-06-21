import '../../libs.dart';

class TransactionDetailScreen extends StatefulWidget {
  static const String RouteName = "/transaction/detail/screen";
  Transaction transaction;
  TransactionDetailScreen(this.transaction, {Key? key}) : super(key: key);

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Transaction Detail"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransactionItem(widget.transaction),
                    UserSmallViewItem(
                      userid: (this.widget.transaction.requesterId ==
                              StaticDataStore.ID)
                          ? this.widget.transaction.sellerId
                          : this.widget.transaction.requesterId,
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.4,
            //   child: (widget.transaction.sellerId == StaticDataStore.ID)
            //       ? SellerTransactionAmendRequest(widget.transaction)
            //       : SizedBox(),
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.4,
            //   child: (widget.transaction.requesterId == StaticDataStore.ID)
            //       ? BuyerTransactionAmendRequest(widget.transaction)
            //       : SizedBox(),
            // )
          ],
        ),
      ),
    );
  }
}

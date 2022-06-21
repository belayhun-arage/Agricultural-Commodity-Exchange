import "../../libs.dart";

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 45),
        height: MediaQuery.of(context).size.height * 0.8,
        child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
          if (state is TransactionsLoaded) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: state.transactions.reversed.map<TransactionItemSmallView>((e) {
                  return TransactionItemSmallView(e);
                }).toList(),
              ),
            );
          } else if (state is TransactionLoading) {
            return Center(
                child: Column(children: [
              CircularProgressIndicator(),
              Text(
                "Transactions loading",
              )
            ]));
          } else {
            return Center(
                child: Text(
              "-------",
            ));
          }
        }));
  }
}

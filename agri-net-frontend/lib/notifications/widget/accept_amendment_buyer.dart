import "../../libs.dart";

class BuyerAcceptTransactionAmendment extends StatefulWidget {
  Transaction transaction;
  TransactionRequest transactionReq;
  BuyerAcceptTransactionAmendment(this.transactionReq, this.transaction, {Key? key}) : super(key: key);

  @override
  State<BuyerAcceptTransactionAmendment> createState() => _BuyerAcceptTransactionAmendmentState();
}

class _BuyerAcceptTransactionAmendmentState extends State<BuyerAcceptTransactionAmendment> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool confirmed = false;
        await showDialog(
            context: context,
            builder: (con) {
              return AlertDialog(
                content: Container(
                  height: 80,
                  child: Column(
                    children: [
                      Text(
                        translate(
                          lang,
                          "are you sure to accept this transaction amendment?",
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      translate(lang, "Cancel"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () {
                      confirmed = false;
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      translate(lang, "Accept"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      confirmed = true;
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        if (confirmed) {
          final result =  await context
              .read<NotificationsBloc>()
              .acceptTransactionAmendment(widget.transactionReq.id);
              
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Text(
              translate(lang, "Accept Amendment"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

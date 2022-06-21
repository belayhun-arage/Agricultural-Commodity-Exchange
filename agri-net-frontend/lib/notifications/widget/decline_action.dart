import "../../libs.dart";
import "package:flutter/material.dart";

class DeclineTransaction extends StatefulWidget {
  Transaction transaction;
  DeclineTransaction(this.transaction, {Key? key}) : super(key: key);

  @override
  State<DeclineTransaction> createState() => _DeclineTransactionState();
}

class _DeclineTransactionState extends State<DeclineTransaction> {
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
                          "are you sure to delete this transaction?",
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
                      translate(lang, "Decline"),
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
          final result = context
              .read<NotificationsBloc>()
              .declineTransaction(widget.transaction.transactionId);
              
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Text(
            translate(lang, "Decline"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

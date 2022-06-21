import "../../libs.dart";
import "package:flutter/material.dart";

import '../model/notification_states.dart';

class TransactionNotificationItem extends StatefulWidget {
  TransactionRequest transactionReq;
  Transaction transaction;
  TransactionNotificationItem(this.transaction, this.transactionReq, {Key? key})
      : super(key: key);

  @override
  State<TransactionNotificationItem> createState() =>
      _TransactionNotificationItemState();
}

class _TransactionNotificationItemState
    extends State<TransactionNotificationItem> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TransactionDetailScreen.RouteName,
            arguments: {"transaction": widget.transaction});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: EdgeInsets.only(
          // horizontal: 10,
          left: StaticDataStore.ID == widget.transaction.requesterId ? 20 : 0,
          right: StaticDataStore.ID == widget.transaction.requesterId ? 0 : 20,
          top: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      translate(lang, "Quantity"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(" : "),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                        "${widget.transactionReq.quantity}   ${context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId) != null ? ((context.watch<ProductTypeBloc>().state is ProductTypeLoadSuccess) ? ((context.watch<ProductTypeBloc>().state as ProductTypeLoadSuccess).getProductTypeByID(context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId)!.typeId)!.getProductUnit().long) : "") : ""}" +
                            "  "
                                "${context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId) != null ? ((context.watch<ProductTypeBloc>().state is ProductTypeLoadSuccess) ? ((context.watch<ProductTypeBloc>().state as ProductTypeLoadSuccess).getProductTypeByID(context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId)!.typeId)!.name) : "") : ""}"),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      translate(lang, "Price"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(" : "),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                        "${widget.transactionReq.price}  ${translate(lang, " Birr ")} "),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      translate(lang, "Description"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(" : "),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "${widget.transactionReq.description}",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      translate(lang, "Created At"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(" : "),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                        "${UnixTime(widget.transactionReq.createdAt).toString()}  ${translate(lang, " before ")}"),
                  )
                ],
              ),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white,
                ),
                color: StaticDataStore.ID == widget.transaction.requesterId
                    ? Theme.of(context).primaryColor
                    : Colors.red,
              ),
              child: Text(
                transaction_states_name[widget.transactionReq.state] != null
                    ? transaction_states_name[widget.transactionReq.state]!
                    : "Unknown",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            widget.transaction.state != 0
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        expand ? Icons.expand_less : Icons.expand_more,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          expand = !expand;
                        });
                      },
                    ),
                  )
                : SizedBox(),
            widget.transaction.state != 0 && expand
                ? ((widget.transaction.state ==
                                TRANSACTION_STATES.TS_CREATED.index ||
                            widget.transaction.state ==
                                TRANSACTION_STATES.TS_AMENDED.index ||
                            widget.transaction.state ==
                                TRANSACTION_STATES
                                    .TS_AMENDMENT_REQUESTED.index) &&
                        widget.transaction.sellerId == StaticDataStore.ID
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DeclineTransaction(widget.transaction),
                          RequestAmendment(
                              widget.transaction, widget.transactionReq),
                          RequestKebd(),
                        ],
                      )
                    : ((widget.transaction.state ==
                                TRANSACTION_STATES.TS_CREATED.index ||
                            widget.transaction.state ==
                                TRANSACTION_STATES.TS_AMENDED.index)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [DeclineTransaction(widget.transaction)],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DeclineTransaction(widget.transaction),
                              // RequestAmendment(),
                              // RequestKebd(),
                              AmendTransaction(
                                  widget.transaction, widget.transactionReq),
                              BuyerAcceptTransactionAmendment(
                                  widget.transactionReq, widget.transaction),
                            ],
                          )))
                : SizedBox(),
            // widget.transactionReq.state != 0
            //     ? GestureDetector(
            //         onTap: () {
            //           //
            //         },
            //         child: Card(
            //           elevation: 3,
            //           child: Container(
            //               // width: 200,
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 8,
            //                 vertical: 3,
            //               ),
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: 8,
            //                 vertical: 10,
            //               ),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 border: Border.all(
            //                   color: Theme.of(context).primaryColor,
            //                 ),
            //                 color: Theme.of(context).primaryColorLight,
            //               ),
            //               child: Row(children: [
            //                 Text(
            //                   transaction_states_name[
            //                               widget.transactionReq.state] !=
            //                           null
            //                       ? transaction_states_name[
            //                           widget.transactionReq.state]!
            //                       : "Unknown",
            //                   style: TextStyle(
            //                     color: Theme.of(context).primaryColor,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 25,
            //                 ),
            //                 Icon(Icons.arrow_right_alt_rounded,
            //                     color: Theme.of(context).primaryColor),
            //               ])),
            //         ),
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}

/*
Text(
                      transaction_states_name[widget.transaction.state] != null
                          ? transaction_states_name[widget.transaction.state]!
                          : "Unknown",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),*/

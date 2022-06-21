import "../../libs.dart";
import "package:flutter/material.dart";

import '../model/notification_states.dart';

class KebdNotificationItem extends StatefulWidget {
  KebdNotificationItem(this.transaction, this.kebdRequest, {Key? key})
      : super(key: key);

  Transaction transaction;
  KebdRequest kebdRequest;
  @override
  State<KebdNotificationItem> createState() => _KebdNotificationItemState();
}

class _KebdNotificationItemState extends State<KebdNotificationItem> {
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
                        "${widget.kebdRequest.kebdAmount}   ${context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId) != null ? ((context.watch<ProductTypeBloc>().state is ProductTypeLoadSuccess) ? ((context.watch<ProductTypeBloc>().state as ProductTypeLoadSuccess).getProductTypeByID(context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId)!.typeId)!.getProductUnit().long) : "") : ""}" +
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
                      "${widget.kebdRequest.description}",
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
                        "${UnixTime(widget.kebdRequest.createdAt ?? (DateTime.now().millisecondsSinceEpoch / 1000).round()).toString()}  ${translate(lang, " before ")}"),
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
                transaction_states_name[widget.transaction.state] != null
                    ? transaction_states_name[widget.transaction.state]!
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
                ? (TRANSACTION_STATES.TS_KEBD_REQUESTED.index ==
                            widget.transaction.state &&
                        StaticDataStore.ID == widget.transaction.sellerId)
                    ? (Column(children: [
                        DeclineTransaction(widget.transaction),
                        RequestKebd(),
                      ]))
                    : ((TRANSACTION_STATES.TS_KEBD_AMENDED.index ==
                                    widget.transaction.state ||
                                TRANSACTION_STATES
                                        .TS_AMENDMENT_REQUESTED.index ==
                                    widget.transaction.state) &&
                            StaticDataStore.ID == widget.transaction.sellerId)
                        ? Column(
                            children: [
                              DeclineTransaction(widget.transaction),
                              AmendKebd(),
                            ],
                          )
                        : (((TRANSACTION_STATES.TS_KEBD_REQUESTED.index ==
                                        widget.transaction.state ||
                                    TRANSACTION_STATES.TS_KEBD_AMENDED.index ==
                                        widget.transaction.state) &&
                                StaticDataStore.ID ==
                                    widget.transaction.requesterId))
                            ? Column(
                                children: [
                                  DeclineTransaction(widget.transaction),
                                  RequestKebdAmendment(),
                                  RequestGuarantee(),
                                ],
                              )
                            : (TRANSACTION_STATES.TS_KEBD_AMENDED.index ==
                                        widget.transaction.state &&
                                    StaticDataStore.ID ==
                                        widget.transaction.requesterId)
                                ? Column(children: [DeclineTransaction(widget.transaction)])
                                : SizedBox()
                : SizedBox(),
            // widget.kebdRequest.state != 0
            //     ? GestureDetector(
            //         onTap: () {
            //           //
            //         },
            //         child: Card(
            //           elevation: 3,
            //           child: Container(
            //             // width: 200,
            //             padding: EdgeInsets.symmetric(
            //               horizontal: 8,
            //               vertical: 3,
            //             ),
            //             margin: EdgeInsets.symmetric(
            //               horizontal: 8,
            //               vertical: 10,
            //             ),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5),
            //               border: Border.all(
            //                 color: Theme.of(context).primaryColor,
            //               ),
            //               color: Colors.white,
            //             ),
            //             child: Row(
            //               children: [
            //                 Text(
            //                   transaction_states_name[
            //                               widget.kebdRequest.state] !=
            //                           null
            //                       ? transaction_states_name[
            //                           widget.kebdRequest.state]!
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
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}

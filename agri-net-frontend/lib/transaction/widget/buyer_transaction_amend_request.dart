import '../../libs.dart';

class BuyerTransactionAmendRequest extends StatefulWidget {
  Transaction transaction;
  BuyerTransactionAmendRequest(this.transaction);

  @override
  State<BuyerTransactionAmendRequest> createState() =>
      _BuyerTransactionAmendRequestState();
}

class _BuyerTransactionAmendRequestState
    extends State<BuyerTransactionAmendRequest> {
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Text("Decline")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Text("Send Amendment"))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            child: Text("Request Guarantee")),
        (selectedIndex == 2) ? amendKebdForm() : SizedBox(),
        (selectedIndex == 3) ? guaranteeForm() : SizedBox()
      ],
    );
    ;
  }

  Widget guaranteeForm() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Text(
                      translate(lang, "Guarantee Amounte "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: priceController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Text(
                          translate(lang, "Birr"),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Text(
                      translate(lang, "Description "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      maxLength: 500,
                      maxLines: null,
                      controller: descriptionController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.description,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {}, child: Text("Commite Guarantee"))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget amendKebdForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Text(
                      translate(lang, "Quantity "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: quantityController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // suffix: Text(
                        //   translate(
                        //       lang,
                        //       (context.watch<ProductTypeBloc>().state
                        //               is ProductTypeLoadSuccess)
                        //           ? ((context.watch<ProductTypeBloc>().state
                        //                           as ProductTypeLoadSuccess)
                        //                       .getProductTypeByID(
                        //                           widget.post.id) ??
                        //                   ProductType.zeroProductType())
                        //               .getProductUnit()
                        //               .long
                        //           : "Unknown"),
                        //   style: TextStyle(
                        //       fontStyle: FontStyle.italic,
                        //       color: Theme.of(context).primaryColor),
                        // )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Text(
                      translate(lang, "Price "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: priceController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Text(
                          translate(lang, "Birr"),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 100,
                    child: Text(
                      translate(lang, "Description "),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      maxLength: 500,
                      maxLines: null,
                      controller: descriptionController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.description,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import '../../libs.dart';

// class BuyyerTransactionAmendRequest extends StatefulWidget {
//   Transaction transaction;
//   BuyyerTransactionAmendRequest(this.transaction);

//   @override
//   State<BuyyerTransactionAmendRequest> createState() =>
//       _BuyyerTransactionAmendRequestState();
// }

// class _BuyyerTransactionAmendRequestState
//     extends State<BuyyerTransactionAmendRequest> {
//   final bool decline = false;
//   final bool sendAmendment = false;
//   final bool sendKebdRequest = false;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           Theme.of(context).primaryColor),
//                       animationDuration: Duration(seconds: 1),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 10,
//                         ),
//                       ),
//                       elevation: MaterialStateProperty.all<double>(0),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "Decline",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     )),
//                 ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           Theme.of(context).primaryColor),
//                       animationDuration: Duration(seconds: 1),
//                       padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 10,
//                         ),
//                       ),
//                       elevation: MaterialStateProperty.all<double>(0),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "Send Amendment",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ))
//               ],
//             ),
//             ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       Theme.of(context).primaryColor),
//                   animationDuration: Duration(seconds: 1),
//                   padding: MaterialStateProperty.all<EdgeInsets>(
//                     EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 10,
//                     ),
//                   ),
//                   elevation: MaterialStateProperty.all<double>(0),
//                 ),
//                 onPressed: () {},
//                 child: Text(
//                   "Send Kebd request",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 )),
//             (sendAmendment == true)
//                 ? SellerTransactionAmendRequest(widget.transaction)
//                 : SizedBox()
//           ],
//         ),
//       ),
//     );
//   }
// }

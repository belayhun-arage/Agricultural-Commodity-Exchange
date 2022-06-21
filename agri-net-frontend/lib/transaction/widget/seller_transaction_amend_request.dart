import '../../libs.dart';

class SellerTransactionAmendRequest extends StatefulWidget {
  Transaction transaction;
  SellerTransactionAmendRequest(this.transaction);

  @override
  State<SellerTransactionAmendRequest> createState() =>
      _SellerTransactionAmendRequestState();
}

class _SellerTransactionAmendRequestState
    extends State<SellerTransactionAmendRequest> {
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String date = "";
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Text("Decline")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Text("Send Amendment"))
              ],
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: Text("Send Kebd Request")),
            ),
            (selectedIndex == 2) ? amendKebdForm() : SizedBox(),
            (selectedIndex == 3) ? kebdRequest() : SizedBox(),
          ],
        ),
      ),
    );
    ;
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

  Widget kebdRequest() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  "Kebd Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(),
                ),
                Text(
                  "Birr",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "DeadLine : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                          });
                      },
                      child: Text("Choose Date"),
                    ),
                    Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                  ],
                ),
              ],
            ),
          ),
          Container(
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
                    onPressed: () {}, child: Text("Send Kebd Requiest")),
              ],
            ),
          )
        ],
      ),
    );
  }
}






// import '../../libs.dart';

// class SellerTransactionAmendRequest extends StatefulWidget {
//   Transaction transaction;
//   SellerTransactionAmendRequest(this.transaction);

//   @override
//   State<SellerTransactionAmendRequest> createState() =>
//       _SellerTransactionAmendRequestState();
// }

// class _SellerTransactionAmendRequestState
//     extends State<SellerTransactionAmendRequest> {
//   bool declineFlag = false;
//   bool amendeFlag = false;
//   bool sendKebdRequest = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     Theme.of(context).primaryColor),
//                 animationDuration: Duration(seconds: 1),
//                 padding: MaterialStateProperty.all<EdgeInsets>(
//                   EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 7.5,
//                   ),
//                 ),
//                 elevation: MaterialStateProperty.all<double>(0),
//               ),
//               onPressed: () {},
//               child: Text(
//                 "Decline",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               )),
//           SizedBox(
//             width: 10,
//           ),
//           ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     Theme.of(context).primaryColor),
//                 animationDuration: Duration(seconds: 1),
//                 padding: MaterialStateProperty.all<EdgeInsets>(
//                   EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 7.5,
//                   ),
//                 ),
//                 elevation: MaterialStateProperty.all<double>(0),
//               ),
//               onPressed: () {
//                 setState(() {
//                   amendeFlag = true;
//                 });
//               },
//               child: Text(
//                 "Send Amendment",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               )),
//         ],
//       ),
//       ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(
//                 Theme.of(context).primaryColor),
//             animationDuration: Duration(seconds: 1),
//             padding: MaterialStateProperty.all<EdgeInsets>(
//               EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 7.5,
//               ),
//             ),
//             elevation: MaterialStateProperty.all<double>(0),
//           ),
//           onPressed: () {
//             sendKebdRequest = true;
//           },
//           child: Text(
//             "Send Kebd Request",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           )),
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Theme.of(context).primaryColor,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Kebd Amount",
//                   style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(),
//                 ),
//                 Text(
//                   "Birr",
//                   style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   "DeadLine : ",
//                   style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Description : ",
//                   style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField()
//               ],
//             ),
//             Row()
//           ],
//         ),
//       )
//         ],
//       ),
//     );
//   }
// }

import '../../libs.dart';

class TransactionRequestAmendmentPoput extends StatefulWidget {
  Transaction transaction;
  TransactionRequest transactionReq;
  TransactionRequestAmendmentPoput(this.transaction, this.transactionReq,
      {Key? key})
      : super(key: key);

  @override
  State<TransactionRequestAmendmentPoput> createState() =>
      _TransactionRequestAmendmentPoputState();
}

class _TransactionRequestAmendmentPoputState
    extends State<TransactionRequestAmendmentPoput> {
  String message = "";
  Color messageColor = Colors.white;
  bool onProgress = false;

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    priceController.text = "${widget.transactionReq.price}";
    descriptionController.text = "${widget.transactionReq.description}";
    quantityController.text = "${widget.transactionReq.quantity}";
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: messageColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              // margin: EdgeInsets.symmetric(
              //   vertical: 4,
              //   horizontal: 4,
              // ),
              width: MediaQuery.of(context).size.width * 0.99,
              // height: 30,
              child: onProgress
                  ? LinearProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )
                  : Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: messageColor,
                      ),
                    ),
            ),
            Container(
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
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: quantityController,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
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
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
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
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
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
            ),
            Row(children: [
              FlatButton(
                  child: Text(
                    translate(lang, "Cancel"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              GestureDetector(
                onTap: () async {
                  try {
                    print(
                        "I Got CLicked ${quantityController.text}  ${priceController.text}  ${descriptionController.text}");
                    if (int.parse(quantityController.text.trim(),
                                onError: (text) {
                              return 0;
                            }) >
                            0 &&
                        double.parse(priceController.text.trim()) > 0 &&
                        descriptionController.text != "") {
                      setState(() {
                        onProgress = true;
                      });
                      final transactionResponse = await context
                          .read<NotificationsBloc>()
                          .amendmentRequest(TransactionInputAmend(
                            price: double.parse(priceController.text),
                            quantity: int.parse(quantityController.text),
                            description: descriptionController.text,
                            transactionID: widget.transaction.transactionId,
                          ));
                      setState(() {
                        onProgress = false;
                      });
                      if (transactionResponse.statusCode == 200 ||
                          transactionResponse.statusCode == 201) {
                        setState(() {
                          message = translate(lang, transactionResponse.msg);
                          messageColor = Colors.green;
                        });
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          message = translate(lang, transactionResponse.msg);
                          messageColor = Colors.red;
                        });
                      }
                    } else if (int.parse(quantityController.text,
                                onError: (text) {
                              return 0;
                            }) <=
                            0 &&
                        int.parse(priceController.text, onError: (text) {
                              return 0;
                            }) <=
                            0 &&
                        descriptionController.text == "") {
                      print("---Here--- ");
                      setState(() {
                        message = translate(lang, " please fill the form ");
                        messageColor = Colors.red;
                      });
                    }
                    if (int.parse(quantityController.text, onError: (te) {
                          return 0;
                        }) <=
                        0) {
                      print("---Heye--- ");

                      setState(() {
                        message = translate(
                            lang, " please provide valid quantity value ");
                        messageColor = Colors.red;
                      });
                    }
                    if (double.parse(priceController.text, (e) {
                          return 0;
                        }) <=
                        0) {
                      print("---Herre--- ");

                      setState(() {
                        message =
                            translate(lang, " please provide valid price ");
                        messageColor = Colors.red;
                      });
                    }
                    if (descriptionController.text.length <= 3) {
                      print("---Hereeee--- ");

                      setState(() {
                        message = translate(
                            lang, " please provide a valid description ");
                        messageColor = Colors.red;
                      });
                    }
                    print("---Here---||| ");
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 20,
                    //   vertical: 10,
                    // ),
                    // color: Theme.of(context).primaryColor,
                    child: Text(
                      translate(
                        lang,
                        "Request",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

import '../../libs.dart';

class CreateTransaction extends StatefulWidget {
  ProductPost post;
  CreateTransaction(this.post, {Key? key}) : super(key: key);

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  String message = "";
  Color messageColor = Colors.white;
  bool onProgress = false;

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
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
                                suffix: Text(
                                  translate(
                                      lang,
                                      (context.watch<ProductTypeBloc>().state
                                              is ProductTypeLoadSuccess)
                                          ? ((context.watch<ProductTypeBloc>().state
                                                          as ProductTypeLoadSuccess)
                                                      .getProductTypeByID(
                                                          widget.post.id) ??
                                                  ProductType.zeroProductType())
                                              .getProductUnit()
                                              .long
                                          : "Unknown"),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Theme.of(context).primaryColor),
                                )),
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
          GestureDetector(
            onTap: () async {
              if (int.parse(quantityController.text, onError: (text) {
                        return 0;
                      }) >
                      0 &&
                  int.parse(quantityController.text, onError: (text) {
                        return 0;
                      }) <=
                      widget.post.remainingQuantity &&
                  int.parse(priceController.text, onError: (text) {
                        return 0;
                      }) >
                      0 &&
                  descriptionController.text != "") {
                //
                print("getting called ...");
                setState(() {
                  onProgress = true;
                });
                final transactionResponse = await context
                    .read<TransactionBloc>()
                    .createTransaction(TransactionInput(
                      double.parse(priceController.text),
                      int.parse(quantityController.text),
                      descriptionController.text,
                      widget.post.id,
                      1,
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
                  context.read<IndexBloc>().add(1);
                  Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.RouteName, (route) => false);
                  // priceController.text = "";
                  // descriptionController.text = "";
                  // quantityController.text = "";
                } else {
                  setState(() {
                    message = translate(lang, transactionResponse.msg);
                    messageColor = Colors.red;
                  });
                }
              } else if (int.parse(quantityController.text, onError: (text) {
                        return 0;
                      }) <=
                      0 &&
                  int.parse(priceController.text, onError: (text) {
                        return 0;
                      }) <=
                      0 &&
                  descriptionController.text == "") {
                setState(() {
                  message = translate(lang, " please fill the form ");
                  messageColor = Colors.red;
                });
              } else if (int.parse(quantityController.text, onError: (text) {
                    return 0;
                  }) >
                  widget.post.remainingQuantity) {
                setState(() {
                  message = translate(lang,
                      " the available products quantity is less than requested ");
                  messageColor = Colors.red;
                });
              }
              if (int.parse(quantityController.text, onError: (te) {
                    return 0;
                  }) <=
                  0) {
                setState(() {
                  message =
                      translate(lang, " please provide valid quantity value ");
                  messageColor = Colors.red;
                });
              }
              if (double.parse(priceController.text, (e) {
                    return 0;
                  }) <=
                  0) {
                setState(() {
                  message = translate(lang, " please provide valid price ");
                  messageColor = Colors.red;
                });
              }
              if (descriptionController.text.length <= 3) {
                setState(() {
                  message =
                      translate(lang, " please provide a valid description ");
                  messageColor = Colors.red;
                });
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  translate(
                    lang,
                    "Request",
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

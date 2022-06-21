import '../../libs.dart';

class ProductForm extends StatefulWidget {
  static String RouteName = "products/post";
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  ProductType? type;
  Store? selectedStore;

  bool negotiablePrice = true;

  bool isPosting = false;
  bool onProgress = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  setMyText(ProductType? produ, String text) {
    setState(() {
      this.type = produ;
      searchController.text = text;
    });
  }

  setMyStore(Store? store) {
    setState(() {
      selectedStore = store;
    });
  }

  String message = "";
  Color messageColor = Colors.white;

  void callWhenCloseBack() {
    setState(() {
      this.selectedStore = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                              translate(lang, " Product Type "),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: type == null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: (String text) async {
                                      final state =
                                          context.read<ProductTypeBloc>().state;
                                      List<ProductType> products = [];
                                      if (state is ProductTypeLoadSuccess) {
                                        products = state.products;
                                      }
                                      Navigator.of(context).pushNamed(
                                          ProductTypeSelectionScreen.RouteName,
                                          arguments: {
                                            "state": state,
                                            "products": products,
                                            "callback": setMyText,
                                            "text": text,
                                          });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        type!.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            type = null;
                                            searchController.text = "";
                                          });
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
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
                                suffixIcon: Icon(
                                  Icons.money,
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
                                suffixIcon: Icon(
                                  Icons.money,
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
                              translate(lang, "Negotiable \n Price"),
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(translate(lang, "Yes")),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Radio(
                                    groupValue: negotiablePrice,
                                    value: true,
                                    onChanged: (resu) {
                                      setState(() {
                                        negotiablePrice = true;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Container(
                                      child: Text("|"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(translate(lang, "No")),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Radio(
                                    groupValue: negotiablePrice,
                                    value: false,
                                    onChanged: (resu) {
                                      setState(() {
                                        negotiablePrice = false;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StaticDataStore.ROLE == ROLE_MERCHANT
                      ? BlocBuilder<StoreBloc, StoreState>(
                          builder: (ctx, state) {
                          return Container(
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
                                      translate(lang, "Select Store "),
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
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: this.selectedStore != null
                                        ? SmallStoreItemView(
                                            this.selectedStore!,
                                            this.callWhenCloseBack)
                                        : FlatButton(
                                            child: Text(
                                              "Select Stores",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              if (state
                                                  is MyStoresLoadedState) {
                                                final stores = state.myStores;
                                                Navigator.of(context).pushNamed(
                                                    StoreSelectionScreen
                                                        .RouteName,
                                                    arguments: {
                                                      "stores": stores,
                                                      "callback": setMyStore,
                                                    });
                                              } else {
                                                print(
                                                    "It is not succesful blocs state");
                                              }
                                            }),
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          isPosting = false;
                          message = "";
                          messageColor = Colors.white;
                          if (type != null &&
                              quantityController.text != "" &&
                              descriptionController.text != "" &&
                              quantityController.text != "" &&
                              priceController.text != "" &&
                              ((StaticDataStore.ROLE == ROLE_MERCHANT &&
                                      selectedStore != null) ||
                                  StaticDataStore.ROLE == ROLE_AGENT)) {
                            setState(() {
                              onProgress = true;
                            });
                            final response = await context
                                .read<MyProductsBloc>()
                                .createProductPost(
                                  ProductPostInput(
                                    typeID: type!.id,
                                    sellingPrice:
                                        double.parse(priceController.text),
                                    storeid: 1,
                                    description: descriptionController.text,
                                    quantity:
                                        int.parse(quantityController.text),
                                    negotiablePrice: negotiablePrice,
                                  ),
                                );
                            setState(() {
                              onProgress = false;
                            });
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              context
                                  .read<MyProductsBloc>()
                                  .add(AddNewProduct(response.crop!));
                              setState(() {
                                message = translate(
                                    lang, "post created succesfully!");
                                messageColor = Colors.green;
                              });
                              Navigator.of(context).pushNamed(
                                  UploadProductPostImages.RouteName,
                                  arguments: {"post": response.crop!});
                            } else {
                              setState(() {
                                message = translate(lang, response.msg);
                                messageColor = Colors.red;
                              });
                            }
                          } else if (type == null &&
                              quantityController.text == "" &&
                              descriptionController.text == "" &&
                              priceController.text == "") {
                            setState(
                              () {
                                message = translate(lang,
                                    "please provide product post informations");
                                messageColor = Colors.red;
                              },
                            );
                            return;
                          }
                          if (type == null) {
                            setState(() {
                              message += "\n" +
                                  translate(lang, "select the product type");
                              messageColor = Colors.red;
                            });
                          } else if (quantityController.text == "" ||
                              int.tryParse(quantityController.text) == 0) {
                            setState(() {
                              message += "\n" +
                                  translate(lang,
                                      "provide the quantity interms of ") +
                                  translate(
                                      lang, "${type!.getProductUnit().long}");
                              messageColor = Colors.red;
                            });
                          }
                          if (descriptionController.text == "") {
                            setState(() {
                              message += "\n" +
                                  translate(lang,
                                      "provide a short description about the product");
                              messageColor = Colors.red;
                            });
                          }
                          if ((priceController.text == "") ||
                              double.tryParse(priceController.text) == 0) {
                            setState(() {
                              message += "\n" +
                                  translate(
                                      lang, "provide valid price value > 0.0");
                              messageColor = Colors.red;
                            });
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            child: Text(
                              translate(lang, "Post"),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

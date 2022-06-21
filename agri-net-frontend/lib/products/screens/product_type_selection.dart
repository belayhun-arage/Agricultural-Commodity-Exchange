import '../../libs.dart';

class ProductTypeSelectionScreen extends StatefulWidget {
  static const String RouteName = "/product_type_selection_screen";
  final ProductTypeState state;
  final List<ProductType> products;
  final Function callBack;
  String text;

  ProductTypeSelectionScreen(
      this.state, this.products, this.callBack, this.text,
      {Key? key})
      : super(key: key);

  @override
  State<ProductTypeSelectionScreen> createState() =>
      _ProductTypeSelectionState(text);
}

class _ProductTypeSelectionState extends State<ProductTypeSelectionScreen> {
  String text = "";
  _ProductTypeSelectionState(String text) {
    this.text = text;
    searchController.text = text;
  }

  ProductType? productType;
  TextEditingController searchController = TextEditingController();

  List<ProductType> filterProductType(List<ProductType> products, String text) {
    if (searchController.text == "") {
      return products;
    }
    List<ProductType> productTypes = [];
    for (final p in products) {
      if (p.name.toLowerCase().toLowerCase().startsWith(text.toLowerCase()) ||
          p.name
              .toLowerCase()
              .startsWith(translate(lang, text.toLowerCase())) ||
          p.name
              .toLowerCase()
              .startsWith(translate("eng", text.toLowerCase())) ||
          p.name
              .toLowerCase()
              .startsWith(translate("amh", text.toLowerCase())) ||
          p.name
              .toLowerCase()
              .startsWith(translate("oro", text.toLowerCase())) ||
          p.name
              .toLowerCase()
              .startsWith(translate("tig", text.toLowerCase()))) {
        productTypes.add(p);
      }
    }
    return productTypes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onChanged: (t) {
                          setState(() {
                            widget.text = t;
                          });
                        },
                        autofocus: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: (widget.state is ProductTypeLoadSuccess)
                              ? filterProductType(widget.products, widget.text)
                                  .map((p) {
                                  return GestureDetector(
                                    onTap: () async {
                                      widget.callBack(p, text);
                                      await Future.delayed(Duration(seconds : 1));
                                      Navigator.of(context).pop();

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(children: [
                                            Text(
                                              p.name,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              p.productionArea,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    137, 48, 47, 47),
                                              ),
                                            ),
                                          ]),
                                          Text(getProductunitByID(p.unitid)!
                                              .long),
                                          Icon(
                                            Icons.add,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList()
                              : [
                                  (widget.state is ProductTypeLoadFailure)
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.replay,
                                                  size: 30,
                                                  color: Colors.blue,
                                                ),
                                                onTap: () {
                                                  context
                                                      .read<ProductTypeBloc>()
                                                      .add(
                                                          ProductTypesLoadEvent());
                                                },
                                              ),
                                              Center(
                                                child: Text(
                                                  translate(
                                                    lang,
                                                    " \tSorry!!\n Can't load the product Types\n${(widget.state as ProductTypeLoadFailure).response.msg}",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            translate(
                                              lang,
                                              " ${widget.state.runtimeType.toString()}\tSorry!!\n No Product type found ",
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

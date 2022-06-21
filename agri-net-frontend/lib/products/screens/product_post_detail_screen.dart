import "../../libs.dart";

class ProductPostDetailScreen extends StatefulWidget {
  static const String RouteName = "/product_post_detail_screen";

  final ProductPost post;
  ProductPostDetailScreen(this.post);
  @override
  ProductDetailScreenState createState() {
    return ProductDetailScreenState();
  }
}

class ProductDetailScreenState extends State<ProductPostDetailScreen> {
  // ProductDetailScreenState();
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    bool seemore = widget.post.description.length > 250;
    context
        .read<UsersBloc>()
        .add(LoadMerchantByStoreIDEvent(widget.post.storeId));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          translate(
            lang,
            "Product Post Detail",
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 3,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductLargePostImages(
                    widget.post.images.length > 0 ? widget.post.images : [0]),
                context.watch<MyProductsBloc>().isMyProduct(widget.post.id)
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        translate(lang, "Delete"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        UploadProductPostImages.RouteName,
                                        arguments: {"post": widget.post});
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      child: Row(children: [
                                        Text(
                                          translate(lang, "Edit"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                          size: 30,
                                        ),
                                      ])))
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: Duration(
                          seconds: 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          (seemore && !expanded)
                              ? (widget.post.description).substring(0, 250)
                              : widget.post.description,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                seemore
                    ? FlatButton(
                        child: Text(
                            translate(
                                    lang, expanded ? "See less" : "See More") +
                                "...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            )),
                        onPressed: () {
                          setState(() {
                            this.expanded = !this.expanded;
                          });
                        })
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.front_hand,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          translate(
                              lang,
                              widget.post.negotiable
                                  ? "Negotiable Price"
                                  : "Fixed price"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.price_check,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          translate(lang, "${widget.post.sellingPrice}"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.production_quantity_limits_outlined,
                          color: widget.post.storeOwned
                              ? Theme.of(context).primaryColor
                              : Colors.yellow,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.post.remainingQuantity} " +
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
                                      : "Unknown") +
                              "  " +
                              translate(lang, " remaining quantity "),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.store,
                          color: widget.post.storeOwned
                              ? Theme.of(context).primaryColor
                              : Colors.yellow,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          translate(
                              lang,
                              widget.post.storeOwned
                                  ? "Posted By Merchant"
                                  : "Posted by agent"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Row(
                  children: [
                    Container(
                      child: (context.watch<ProductTypeBloc>().state
                              is ProductTypeLoadSuccess)
                          ? ProductTypeSmallView(
                              type: ((context.watch<ProductTypeBloc>().state
                                          as ProductTypeLoadSuccess)
                                      .getProductTypeByID(widget.post.id) ??
                                  ProductType.zeroProductType()))
                          : Text(
                              "Unknown",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
                UserSmallViewItem(storeid: this.widget.post.storeId),
                GestureDetector(
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Buy",
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CreateTransactionScreen.RouteName,
                      arguments: {
                        "post": widget.post,
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

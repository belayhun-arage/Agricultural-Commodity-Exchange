import "../../libs.dart";

class ProductPostItem extends StatefulWidget {
  final ProductPost post;

  ProductPostItem({required this.post});
  @override
  State createState() {
    return ProductPostItemState();
  }
}

class ProductPostItemState extends State<ProductPostItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    bool seemore = widget.post.description.length > 250;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductPostDetailScreen.RouteName,
          arguments: {
            "post": widget.post,
          },
        );
      },
      child: ClipRRect(
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
          child: Column(
            children: [
              ProductPostImages(
                  widget.post.images.length > 0 ? widget.post.images : [0]),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
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
                        width: MediaQuery.of(context).size.width * 0.74,
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
              ),
              seemore
                  ? FlatButton(
                      child: Text(
                          translate(lang, expanded ? "See less" : "See More") +
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              )

              // Row(
              //   children: [
              //     Container(
              //       child: (context.watch<ProductTypeBloc>().state
              //               is ProductTypeLoadSuccess)
              //           ? ProductTypeSmallView(
              //               type: ((context.watch<ProductTypeBloc>().state
              //                           as ProductTypeLoadSuccess)
              //                       .getProductTypeByID(widget.post.id) ??
              //                   ProductType.zeroProductType()))
              //           : Text(
              //               "Unknown",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

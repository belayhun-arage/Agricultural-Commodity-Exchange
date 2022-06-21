import "../../libs.dart";

class ProductItemSmallView extends StatefulWidget {
  final ProductPost post;
  const ProductItemSmallView(this.post, {Key? key}) : super(key: key);

  @override
  State<ProductItemSmallView> createState() => _ProductItemSmallViewState();
}

class _ProductItemSmallViewState extends State<ProductItemSmallView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      // margin: EdgeInsets.symmetric(
      //   horizontal: 5,
      // ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.category,
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
                          (context.watch<ProductTypeBloc>().state
                                  is ProductTypeLoadSuccess)
                              ? ((context.watch<ProductTypeBloc>().state
                                              as ProductTypeLoadSuccess)
                                          .getProductTypeByID(widget.post.id) ??
                                      ProductType.zeroProductType())
                                  .name
                              : "Unknown") +
                      " / " +
                      translate(
                          lang,
                          (context.watch<ProductTypeBloc>().state
                                  is ProductTypeLoadSuccess)
                              ? ((context.watch<ProductTypeBloc>().state
                                              as ProductTypeLoadSuccess)
                                          .getProductTypeByID(widget.post.id) ??
                                      ProductType.zeroProductType())
                                  .productionArea
                              : "Unknown"),
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
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.price_check,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  translate(lang, "${widget.post.sellingPrice}") +
                      " " +
                      translate(lang, "birr"),
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
              child: SingleChildScrollView(
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
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
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
                          overflow: TextOverflow.clip,
                        ),
                        overflow: TextOverflow.clip),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

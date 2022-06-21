import "../../libs.dart";

class TransactionItemSmallView extends StatefulWidget {
  Transaction transaction;
  TransactionItemSmallView(this.transaction, {Key? key}) : super(key: key);

  @override
  State<TransactionItemSmallView> createState() =>
      _TransactionItemSmallViewState();
}

class _TransactionItemSmallViewState extends State<TransactionItemSmallView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TransactionDetailScreen.RouteName,
            arguments: {"transaction": widget.transaction});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
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
                        "${widget.transaction.quantity}   ${context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId) != null ? ((context.watch<ProductTypeBloc>().state is ProductTypeLoadSuccess) ? ((context.watch<ProductTypeBloc>().state as ProductTypeLoadSuccess).getProductTypeByID(context.watch<ProductsBloc>().getProductPostByID(widget.transaction.productId)!.typeId)!.getProductUnit().long) : "") : ""}" +
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
                      translate(lang, "Price"),
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
                        "${widget.transaction.price}  ${translate(lang, " Birr ")} "),
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
                        "${UnixTime(widget.transaction.createdAt).toString()}  ${translate(lang, " before ")}"),
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
                StaticDataStore.ID == widget.transaction.requesterId
                    ? "Requested by you"
                    : "Requested Other",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

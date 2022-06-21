import "../../libs.dart";

class ProductTypeSmallView extends StatefulWidget {
  ProductType type;
  ProductTypeSmallView({required this.type, Key? key}) : super(key: key);

  @override
  State<ProductTypeSmallView> createState() => _ProductTypeSmallViewState();
}

class _ProductTypeSmallViewState extends State<ProductTypeSmallView> {
  bool more = false;

  @override
  Widget build(BuildContext context) {
    final moreinfo = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              translate(
                lang,
                "Current Price",
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(flex: 1, child: Text(":")),
          Expanded(
            flex: 3,
            child: Text(
              "${widget.type.currentPrice}",
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              translate(
                lang,
                "Last updated at",
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(flex: 1, child: Text(":")),
          Expanded(
            flex: 3,
            child: Text(
              UnixTime(widget.type.lastUpdateTime).toString() +
                  " " +
                  translate(lang, "before"),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    translate(
                      lang,
                      "Type",
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(flex: 1, child: Text(":")),
                Expanded(
                  flex: 3,
                  child: Text(widget.type.name,
                      textAlign: TextAlign.left, style: TextStyle()),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      translate(
                        lang,
                        "Unit",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(flex: 1, child: Text(":")),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.type.getProductUnit().long,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      translate(
                        lang,
                        "Production Area",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(flex: 1, child: Text(":")),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.type.productionArea,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              ...(more ? moreinfo : [SizedBox()]),
              Positioned(
                right: 0,
                bottom: 5,
                child: IconButton(
                  icon: Icon(more ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      this.more = !this.more;
                    });
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

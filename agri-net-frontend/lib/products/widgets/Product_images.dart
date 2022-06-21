import "../../libs.dart";

class ProductPostImages extends StatefulWidget {
  final List<int> imageIds;
  const ProductPostImages(this.imageIds, {Key? key}) : super(key: key);

  @override
  State<ProductPostImages> createState() => _ProductPostImagesState();
}

class _ProductPostImagesState extends State<ProductPostImages> {
  @override
  Widget build(BuildContext context) {
    return widget.imageIds.length == 0
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColorLight),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: widget.imageIds.length == 1
                        ? ProductPostSingleImageItem(widget.imageIds[0])
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProductPostSingleImageItem(widget.imageIds[0]),
                            ],
                          ),
                  ),
                  widget.imageIds.length <= 1
                      ? SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.imageIds
                                .sublist(1, widget.imageIds.length)
                                .map<ProductPostSingleImageItem>((id) {
                              return ProductPostSingleImageItem(id);
                            }).toList(),
                          ),
                        )
                ],
              ),
            ),
          );
  }
}

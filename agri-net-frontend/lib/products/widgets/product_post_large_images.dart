import "../../libs.dart";

class ProductLargePostImages extends StatefulWidget {
  final List<int> imageIds;
  const ProductLargePostImages(this.imageIds, {Key? key}) : super(key: key);

  @override
  State<ProductLargePostImages> createState() => _ProductPostLargeImagesState();
}

class _ProductPostLargeImagesState extends State<ProductLargePostImages> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.imageIds.length < 1
                      ? SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                widget.imageIds.map<ProductPostSingleImageItem>(
                              (id) {
                                return ProductPostSingleImageItem(id);
                              },
                            ).toList(),
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}

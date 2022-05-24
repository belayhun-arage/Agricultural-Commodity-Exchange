import '../../libs.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final String amounte;
  final double price;
  final String imgUrl1;
  final String imgUrl2;
  final String imgUrl3;
  const ProductPage(this.title, this.amounte, this.price, this.imgUrl1,
      this.imgUrl2, this.imgUrl3);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Material(
      elevation: 20,
      child: Card(
        // color: productCardColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              productInfo(widget.title, widget.amounte, widget.price),
              SizedBox(
                width: 5,
              ),
              productImage(widget.imgUrl1),
              // productImage(widget.imgUrl2),
              // productImage(widget.imgUrl3)
            ],
          ),
        ),
      ),
    );
  }

  Widget productInfo(String title, String amounte, double price) {
    return Column(
      children: [
        Text(
          title,
          style: productInfoStyle,
        ),
        Text(
          "Amounte: " + amounte,
          style: productInfoStyle,
        ),
        Row(
          children: [
            Text(
              "Price: " + price.toString(),
              style: productInfoStyle,
            )
          ],
        )
      ],
    );
  }

  Widget productImage(String url) {
    return Positioned.fill(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        url,
        width: 65,
        height: 65,
        fit: BoxFit.cover,
      ),
    ));
  }
}
